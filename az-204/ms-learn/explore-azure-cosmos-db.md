# Explore Azure Cosmos DB

## Introduction

Azure Cosmos DB is a globally distributed database system that allows you to read and write data from the local replicas of your database and it transparently replicates the data to all the regions associated with your Cosmos account.

After completing this module, you'll be able to:

- Identify the key benefits provided by Azure Cosmos DB
- Describe the elements in an Azure Cosmos DB account and how they're organized
- Explain the different consistency levels and choose the correct one for your project
- Explore the APIs supported in Azure Cosmos DB and choose the appropriate API for your solution
- Describe how request units impact costs
- Create Azure Cosmos DB resources by using the Azure portal.

## Identify key benefits of Azure Cosmos DB

Azure Cosmos DB is a fully managed NoSQL database designed to provide low latency, elastic scalability of throughput, well-defined semantics for data consistency, and high availability.

You can configure your databases to be globally distributed and available in any of the Azure regions. To lower the latency, place the data close to where your users are. Choosing the required regions depends on the global reach of your application and where your users are located.

With Azure Cosmos DB, you can add or remove the regions associated with your account at any time. Your application doesn't need to be paused or redeployed to add or remove a region.

### Key benefits of global distribution

With its novel multi-master replication protocol, every region supports both writes and reads. The multi-master capability also enables:

- Unlimited elastic write and read scalability.
- 99.999% read and write availability all around the world.
- Guaranteed reads and writes served in less than 10 milliseconds at the 99th percentile.

Your application can perform near real-time reads and writes against all the regions you chose for your database. Azure Cosmos DB internally handles the data replication between regions with consistency level guarantees of the level you selected.

Running a database in multiple regions worldwide increases the availability of a database. If one region is unavailable, other regions automatically handle application requests. Azure Cosmos DB offers 99.999% read and write availability for multi-region databases.

## Explore the resource hierarchy

The Azure Cosmos DB account is the fundamental unit of global distribution and high availability. Your Azure Cosmos DB account contains a unique Domain Name System (DNS) name and you can manage an account by using the Azure portal or the Azure CLI, or by using different language-specific SDKs. For globally distributing your data and throughput across multiple Azure regions, you can add and remove Azure regions to your account at any time.

### Elements in an Azure Cosmos DB account

An Azure Cosmos DB container is the fundamental unit of scalability. You can virtually have an unlimited provisioned throughput (RU/s) and storage on a container. Azure Cosmos DB transparently partitions your container using the logical partition key that you specify in order to elastically scale your provisioned throughput and storage.

Currently, you can create a maximum of 50 Azure Cosmos DB accounts under an Azure subscription (can be increased via support request). After you create an account under your Azure subscription, you can manage the data in your account by creating databases, containers, and items.

The following image shows the hierarchy of different entities in an Azure Cosmos DB account:

> _Image: Hierarchy of Azure Cosmos DB entities — Database accounts are at the top, databases are grouped under accounts, and containers are grouped under databases._

### Azure Cosmos DB databases

You can create one or multiple Azure Cosmos DB databases under your account. A database is analogous to a namespace. A database is the unit of management for a set of Azure Cosmos DB containers.

### Azure Cosmos DB containers

An Azure Cosmos DB container is where data is stored. Unlike most relational databases, which scale up with larger sizes of virtual machines, Azure Cosmos DB scales out.

Data is stored on one or more servers called _partitions_. To increase partitions, you increase throughput, or they grow automatically as storage increases. This relationship provides a virtually unlimited amount of throughput and storage for a container.

When you create a container, you need to supply a partition key. The partition key is a property that you select from your items to help Azure Cosmos DB distribute the data efficiently across partitions. Azure Cosmos DB uses the value of this property to route data to the appropriate partition to be written, updated, or deleted. You can also use the partition key in the `WHERE` clause in queries for efficient data retrieval.

The underlying storage mechanism for data in Azure Cosmos DB is called a _physical partition_. Physical partitions can have a throughput amount up to 10,000 Request Units per second, and they can store up to 50 GB of data. Azure Cosmos DB abstracts this partitioning concept with a logical partition, which can store up to 20 GB of data.

When you create a container, you configure throughput in one of the following modes:

- **Dedicated throughput**: The throughput on a container is exclusively reserved for that container. There are two types of dedicated throughput: standard and autoscale.
- **Shared throughput**: Throughput is specified at the database level and then shared with up to 25 containers within the database. Sharing of throughput excludes containers that are configured with their own dedicated throughput.

### Azure Cosmos DB items

Depending on which API you use, individual data entities can be represented in various ways:

| Azure Cosmos DB entity | API for NoSQL | API for Cassandra | API for MongoDB | API for Gremlin | API for Table |
| ---------------------- | ------------- | ----------------- | --------------- | --------------- | ------------- |
| Azure Cosmos DB item   | Item          | Row               | Document        | Node or edge    | Item          |

## Explore consistency levels

Azure Cosmos DB approaches data consistency as a spectrum of choices instead of two extremes. Strong consistency and eventual consistency are at the ends of the spectrum, but there are many consistency choices along the spectrum. Developers can use these options to make precise choices and granular tradeoffs with respect to high availability and performance.

Azure Cosmos DB offers five well-defined levels. From strongest to weakest, the levels are:

- Strong
- Bounded staleness
- Session
- Consistent prefix
- Eventual

Each level provides availability and performance tradeoffs. The following image shows the different consistency levels as a spectrum.

> _Image: Data consistency shown as a spectrum from strong to eventual._

The consistency levels are region-agnostic and are guaranteed for all operations, regardless of:

- The region where the reads and writes are served
- The number of regions associated with your Azure Cosmos DB account
- Whether your account is configured with a single or multiple write regions.

Read consistency applies to a single read operation scoped within a partition-key range or a logical partition.

## Choose the right consistency level

Each of the consistency models can be used for specific real-world scenarios. Each provides precise availability and performance tradeoffs backed by comprehensive SLAs. The following simple considerations help you make the right choice in many common scenarios.

### Configure the default consistency level

You can configure the default consistency level on your Azure Cosmos DB account at any time. The default consistency level configured on your account applies to all Azure Cosmos DB databases and containers under that account. All reads and queries issued against a container or a database use the specified consistency level by default.

Read consistency applies to a single read operation scoped within a logical partition. The read operation can be issued by a remote client or a stored procedure.

### Guarantees associated with consistency levels

Azure Cosmos DB guarantees that 100 percent of read requests meet the consistency guarantee for the consistency level chosen. The precise definitions of the five consistency levels in Azure Cosmos DB using the TLA+ specification language are provided in the [azure-cosmos-tla](https://github.com/Azure/azure-cosmos-tla) GitHub repo.

#### Strong consistency

Strong consistency offers a linearizability guarantee. Linearizability refers to serving requests concurrently. The reads are guaranteed to return the most recent committed version of an item. A client never sees an uncommitted or partial write. Users are always guaranteed to read the latest committed write.

#### Bounded staleness consistency

In bounded staleness consistency, the lag of data between any two regions is always less than a specified amount. The amount can be _K_ versions (that is, _updates_) of an item or by _T_ time intervals, whichever is reached first. In other words, when you choose bounded staleness, the maximum "staleness" of the data in any region can be configured in two ways:

- The number of versions (_K_) of the item
- The time interval (_T_) reads might lag behind the writes

Bounded Staleness is beneficial primarily to single-region write accounts with two or more regions. If the data lag in a region (determined per physical partition) exceeds the configured staleness value, writes for that partition are throttled until staleness is back within the configured upper bound.

For a single-region account, Bounded Staleness provides the same write consistency guarantees as Session and Eventual Consistency. With Bounded Staleness, data is replicated to a local majority (three replicas in a four replica set) in the single region.

#### Session consistency

In session consistency, within a single client session, reads are guaranteed to honor the read-your-writes, and write-follows-reads guarantees. This guarantee assumes a single "writer" session or sharing the session token for multiple writers.

Like all consistency levels weaker than Strong, writes are replicated to a minimum of three replicas (in a four replica set) in the local region, with asynchronous replication to all other regions.

#### Consistent prefix consistency

In consistent prefix, updates made as single document writes see eventual consistency. Updates made as a batch within a transaction, are returned consistent to the transaction in which they were committed. Write operations within a transaction of multiple documents are always visible together.

Assume two write operations are performed on documents _Doc 1_ and _Doc 2_, within transactions T1 and T2. When client does a read in any replica, the user sees either "_Doc 1_ v1 and _Doc 2_ v1" or "_Doc 1_ v2 and _Doc 2_ v2," but never "_Doc 1_ v1 and _Doc 2_ v2" or "_Doc 1_ v2 and _Doc 2_ v1" for the same read or query operation.

#### Eventual consistency

In eventual consistency, there's no ordering guarantee for reads. In the absence of any further writes, the replicas eventually converge.

Eventual consistency is the weakest form of consistency because a client might read the values that are older than the ones it read before. Eventual consistency is ideal where the application doesn't require any ordering guarantees. Examples include count of Retweets, Likes, or nonthreaded comments.

## Explore supported APIs

Azure Cosmos DB offers multiple database APIs, which include NoSQL, MongoDB, PostgreSQL, Cassandra, Gremlin, and Table. By using these APIs, you can model real world data using documents, key-value, graph, and column-family data models. These APIs allow your applications to treat Azure Cosmos DB as if it were various other databases technologies, without the overhead of management, and scaling approaches. Azure Cosmos DB helps you to use the ecosystems, tools, and skills you already have for data modeling and querying with its various APIs.

All the APIs offer automatic scaling of storage and throughput, flexibility, and performance guarantees. There's no one best API, and you can choose any one of the APIs to build your application.

### Considerations when choosing an API

API for NoSQL is native to Azure Cosmos DB.

API for MongoDB, PostgreSQL, Cassandra, Gremlin, and Table implement the wire protocol of open-source database engines. These APIs are best suited if the following conditions are true:

- If you have existing MongoDB, PostgreSQL, Cassandra, or Gremlin applications
- If you don't want to rewrite your entire data access layer
- If you want to use the open-source developer ecosystem, client-drivers, expertise, and resources for your database

### API for NoSQL

The Azure Cosmos DB API for NoSQL stores data as JSON documents (called items). It offers the best end-to-end experience as we have full control over the interface, service, and the SDK client libraries. Any new feature that is rolled out to Azure Cosmos DB is first available on API for NoSQL accounts. NoSQL accounts provide support for querying items using the Structured Query Language (SQL) syntax.

### API for MongoDB

The Azure Cosmos DB API for MongoDB stores data in a document structure, via BSON format. It's compatible with MongoDB wire protocol; however, it doesn't use any native MongoDB related code. The API for MongoDB is a great choice if you want to use the broader MongoDB ecosystem and skills, without compromising on using Azure Cosmos DB features.

### API for PostgreSQL

Azure Cosmos DB for PostgreSQL is a managed service for running PostgreSQL at any scale, with the [Citus open source](https://github.com/citusdata/citus) superpower of distributed tables. It stores data either on a single node, or distributed in a multi-node configuration.

### API for Apache Cassandra

The Azure Cosmos DB API for Cassandra stores data in column-oriented schema. Apache Cassandra offers a highly distributed, horizontally scaling approach to storing large volumes of data while offering a flexible approach to a column-oriented schema. API for Cassandra in Azure Cosmos DB aligns with this philosophy to approaching distributed NoSQL databases. This API for Cassandra is wire protocol compatible with native Apache Cassandra.

### API for Apache Gremlin

The Azure Cosmos DB API for Gremlin allows users to make graph queries and stores data as edges and vertices.

Use the API for Gremlin for scenarios:

- Involving dynamic data
- Involving data with complex relations
- Involving data that is too complex to be modeled with relational databases
- If you want to use the existing Gremlin ecosystem and skills

### API for Table

The Azure Cosmos DB API for Table stores data in key/value format. If you're currently using Azure Table storage, you might see some limitations in latency, scaling, throughput, global distribution, index management, low query performance. API for Table overcomes these limitations and the recommendation is to migrate your app if you want to use the benefits of Azure Cosmos DB. API for Table only supports OLTP scenarios.

## Discover request units

With Azure Cosmos DB, you pay for the throughput you provision and the storage you consume on an hourly basis. Throughput must be provisioned to ensure that sufficient system resources are available for your Azure Cosmos database always.

The cost of all database operations is normalized in Azure Cosmos DB and expressed by _request units_ (or RUs, for short). A request unit represents the system resources such as CPU, IOPS, and memory that are required to perform the database operations supported by Azure Cosmos DB.

The cost to do a point read, which is fetching a single item by its ID and partition key value, for a 1-KB item is 1RU. All other database operations are similarly assigned a cost using RUs. No matter which API you use to interact with your Azure Cosmos container, costs are measured by RUs. Whether the database operation is a write, point read, or query, costs are measured in RUs.

> _Image: Database operations consuming request units — showing reads, writes, and queries all consuming RUs._

The type of Azure Cosmos DB account you're using determines the way consumed RUs get charged. There are two modes for account creation:

- **Provisioned throughput mode**: In this mode, you provision the number of RUs for your application on a per-second basis in increments of 100 RUs per second. To scale the provisioned throughput for your application, you can increase or decrease the number of RUs at any time in increments or decrements of 100 RUs. You can make your changes either programmatically or by using the Azure portal. You can provision throughput at container and database granularity level.
- **Serverless mode**: In this mode, you don't have to provision any throughput when creating resources in your Azure Cosmos DB account. At the end of your billing period, you get billed for the number of request units consumed by your database operations.

## Exercise: Create Azure Cosmos DB resources by using the Azure portal

> **Note:** This unit contains a hands-on lab exercise. The exercise is not reproduced here — visit the Microsoft Learn module to complete it.

In this exercise you learn how to perform the following actions in the Azure portal:

- Create an Azure Cosmos DB account
- Add a database and a container
- Add data to your database
- Clean up resources

### Prerequisites

- An Azure account with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free).

### Create an Azure Cosmos DB account

1. Sign-in to the [Azure portal](https://portal.azure.com).
2. From the Azure portal navigation pane, select **+ Create a resource**.
3. Search for **Azure Cosmos DB**, then select **Create/Azure Cosmos DB** to get started.
4. On the **Which API best suits your workload?** page, select **Create** in the **Azure Cosmos DB for NoSQL** box.
5. In the **Create Azure Cosmos DB Account - Azure Cosmos DB for NoSQL** page, enter the basic settings for the new Azure Cosmos DB account.
    - **Subscription**: Select the subscription you want to use.
    - **Resource Group**: Select **Create new**, then enter _az204-cosmos-rg_.
    - **Account Name**: Enter a _unique_ name to identify your Azure Cosmos account. The name can only contain lowercase letters, numbers, and the hyphen (-) character. It must be between 3-31 characters in length.
    - **Availability Zones**: Select **Disable**.
    - **Location**: Use the location that is closest to your users to give them the fastest access to the data.
    - **Capacity mode**: Select **Serverless**.
6. Select **Review + create**.
7. Review the account settings, and then select **Create**. It takes a few minutes to create the account. Wait for the portal page to display **Your deployment is complete**.
8. Select **Go to resource** to go to the Azure Cosmos DB account page.

### Add a database and a container

You can use the Data Explorer in the Azure portal to create a database and container.

1. Select **Data Explorer** from the left navigation on your Azure Cosmos DB account page, and then select **New Container**.
2. In the **New container** pane, enter the settings for the new container.
    - **Database ID**: Select **Create new**, and enter _ToDoList_.
    - **Container ID**: Enter _Items_
    - **Partition key**: Enter _/category_. The samples in this demo use _/category_ as the partition key.
3. Select **OK**. The Data Explorer displays the new database and the container that you created.

### Add data to your database

Add data to your new database using Data Explorer.

1. In **Data Explorer**, expand the **ToDoList** database, and expand the **Items** container. Next, select **Items**, and then select **New Item**.
2. Add the following structure to the item on the right side of the **Items** pane:

```json
{
    "id": "1",
    "category": "personal",
    "name": "groceries",
    "description": "Pick up apples and strawberries.",
    "isComplete": false
}
```

3. Select **Save**.
4. Select **New Item** again, and create and save another item with a unique `id`, and any other properties and values you want. Your items can have any structure, because Azure Cosmos DB doesn't impose any schema on your data.

### Clean up resources

1. Select **Overview** from the left navigation on your Azure Cosmos DB account page.
2. Select the **az204-cosmos-rg** resource group link in the Essentials group.
3. Select **Delete** resource group and follow the directions to delete the resource group and all of the resources it contains.

## Summary

In this module you learned how to:

- Identify the key benefits provided by Azure Cosmos DB
- Describe the elements in an Azure Cosmos DB account and how they're organized
- Explain the different consistency levels and choose the correct one for your project
- Explore the APIs supported in Azure Cosmos DB and choose the appropriate API for your solution
- Describe how request units impact costs
- Create Azure Cosmos DB resources by using the Azure portal.
