# Explore Azure Blob Storage

## Introduction

This module will delve into the world of Azure Blob storage, Microsoft's cloud-based solution for storing large amounts of unstructured data. This service is versatile and can be used for a variety of purposes, from serving images or documents to a browser, to storing files for distributed access, and even streaming video and audio.

The topics covered in this module include:

- Understanding Azure Blob Storage: Features, Types of Storage Accounts, and Access Tiers
- Understanding Azure Blob Storage: Storage Accounts, Containers, and Blobs
- Understanding Azure Storage Security and Encryption Features

## Explore Azure Blob storage

Azure Blob storage is Microsoft's object storage solution for the cloud. Blob storage is optimized for storing massive amounts of unstructured data. Unstructured data is data that doesn't adhere to a particular data model or definition, such as text or binary data.

Blob storage is designed for:

- Serving images or documents directly to a browser.
- Storing files for distributed access.
- Streaming video and audio.
- Writing to log files.
- Storing data for backup and restore, disaster recovery, and archiving.
- Storing data for analysis by an on-premises or Azure-hosted service.

Users or client applications can access objects in Blob storage via HTTP/HTTPS, from anywhere in the world. Objects in Blob storage are accessible via the Azure Storage REST API, Azure PowerShell, Azure CLI, or an Azure Storage client library.

An Azure Storage account is the top-level container for all of your Azure Blob storage. The storage account provides a unique namespace for your Azure Storage data that is accessible from anywhere in the world over HTTP or HTTPS.

### Types of storage accounts

Azure Storage offers two performance levels of storage accounts, standard and premium. Each performance level supports different features and has its own pricing model.

- **Standard:** This is the standard general-purpose v2 account and is recommended for most scenarios using Azure Storage.
- **Premium:** Premium accounts offer higher performance by using solid-state drives. If you create a premium account you can choose between three account types, block blobs, page blobs, or file shares.

The following table describes the types of storage accounts recommended by Microsoft for most scenarios using Blob storage.

| Type of storage account     | Supported storage services                                                                | Redundancy options                                                                                                                                                                                                               | Usage                                                                                                                                                                                                                                     |
| --------------------------- | ----------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Standard general-purpose v2 | Blob Storage (including Data Lake Storage), Queue Storage, Table Storage, and Azure Files | Locally redundant storage (LRS) / geo-redundant storage (GRS) / read-access geo-redundant storage (RA-GRS) / Zone-redundant storage (ZRS) / geo-zone-redundant storage (GZRS) / read-access geo-zone-redundant storage (RA-GZRS) | Standard storage account type for blobs, file shares, queues, and tables. Recommended for most scenarios using Azure Storage. If you want support for network file system (NFS) in Azure Files, use the premium file shares account type. |
| Premium block blobs         | Blob Storage (including Data Lake Storage)                                                | LRS and ZRS                                                                                                                                                                                                                      | Premium storage account type for block blobs and append blobs. Recommended for scenarios with high transaction rates or that use smaller objects or require consistently low storage latency.                                             |
| Premium file shares         | Azure Files                                                                               | LRS and ZRS                                                                                                                                                                                                                      | Premium storage account type for file shares only. Recommended for enterprise or high-performance scale applications.                                                                                                                     |
| Premium page blobs          | Page blobs only                                                                           | LRS and ZRS                                                                                                                                                                                                                      | Premium storage account type for page blobs only.                                                                                                                                                                                         |

### Access tiers for block blob data

Azure Storage provides different options for accessing block blob data based on usage patterns. Each access tier in Azure Storage is optimized for a particular pattern of data usage. By selecting the right access tier for your needs, you can store your block blob data in the most cost-effective manner.

The available access tiers are:

- The **Hot** access tier, which is optimized for frequent access of objects in the storage account. The Hot tier has the highest storage costs, but the lowest access costs. New storage accounts are created in the hot tier by default.
- The **Cool** access tier, which is optimized for storing large amounts of data that is infrequently accessed and stored for a minimum of 30 days. The Cool tier has lower storage costs and higher access costs compared to the Hot tier.
- The **Cold** access tier, which is optimized for storing data that is infrequently accessed and stored for a minimum of 90 days. The cold tier has lower storage costs and higher access costs compared to the cool tier.
- The **Archive** tier, which is available only for individual block blobs. The archive tier is optimized for data that can tolerate several hours of retrieval latency and remains in the Archive tier for a minimum 180 days. The archive tier is the most cost-effective option for storing data, but accessing that data is more expensive than accessing data in the hot or cool tiers.

If there's a change in the usage pattern of your data, you can switch between these access tiers at any time.

## Discover Azure Blob storage resource types

Blob storage offers three types of resources:

- The **storage account**.
- A **container** in the storage account
- A **blob** in a container

### Storage accounts

A storage account provides a unique namespace in Azure for your data. Every object that you store in Azure Storage has an address that includes your unique account name. The combination of the account name and the Azure Storage blob endpoint forms the base address for the objects in your storage account.

For example, if your storage account is named _mystorageaccount_, then the default endpoint for Blob storage is:

```
http://mystorageaccount.blob.core.windows.net
```

### Containers

A container organizes a set of blobs, similar to a directory in a file system. A storage account can include an unlimited number of containers, and a container can store an unlimited number of blobs.

A container name must be a valid DNS name, as it forms part of the unique URI (Uniform resource identifier) used to address the container or its blobs. Follow these rules when naming a container:

- Container names can be between 3 and 63 characters long.
- Container names must start with a letter or number, and can contain only lowercase letters, numbers, and the dash (-) character.
- Two or more consecutive dash characters aren't permitted in container names.

The URI for a container is similar to:

```bash
https://myaccount.blob.core.windows.net/mycontainer
```

### Blobs

Azure Storage supports three types of blobs:

- **Block blobs** store text and binary data. Block blobs are made up of blocks of data that can be managed individually. Block blobs can store up to about 190.7 TiB.
- **Append blobs** are made up of blocks like block blobs, but are optimized for append operations. Append blobs are ideal for scenarios such as logging data from virtual machines.
- **Page blobs** store random access files up to 8 TB in size. Page blobs store virtual hard drive (VHD) files and serve as disks for Azure virtual machines.

The URI for a blob is similar to:

```bash
https://myaccount.blob.core.windows.net/mycontainer/myblob
```

or

```bash
https://myaccount.blob.core.windows.net/mycontainer/myvirtualdirectory/myblob
```

## Explore Azure Storage security features

Azure Storage uses service-side encryption (SSE) to automatically encrypt your data when it's persisted to the cloud. Azure Storage encryption protects your data and to help you to meet your organizational security and compliance commitments.

Microsoft recommends using service-side encryption to protect your data for most scenarios. However, the Azure Storage client libraries for Blob Storage and Queue Storage also provide client-side encryption for customers who need to encrypt data on the client.

### Azure Storage encryption for data at rest

Azure Storage automatically encrypts your data when persisting it to the cloud. Encryption protects your data and helps you meet your organizational security and compliance commitments. Data in Azure Storage is encrypted and decrypted transparently using 256-bit Advanced Encryption Standard (AES) encryption, one of the strongest block ciphers available, and is Federal Information Processing Standards (FIPS) 140-2 compliant. Azure Storage encryption is similar to BitLocker encryption on Windows.

Azure Storage encryption is enabled for all storage accounts and can't be disabled. Because your data is secured by default, you don't need to modify your code or applications to take advantage of Azure Storage encryption.

Data in a storage account is encrypted regardless of performance tier, access tier, or deployment model. All new and existing block blobs, append blobs, and page blobs are encrypted, including blobs in the archive tier. All Azure Storage redundancy options support encryption, and all data in both the primary and secondary regions is encrypted when geo-replication is enabled. All Azure Storage resources are encrypted, including blobs, disks, files, queues, and tables. All object metadata is also encrypted.

There's no extra cost for Azure Storage encryption.

#### Encryption key management

Data in a new storage account is encrypted with Microsoft-managed keys by default. You can continue to rely on Microsoft-managed keys for the encryption of your data, or you can manage encryption with your own keys. If you choose to manage encryption with your own keys, you have two options. You can use either type of key management, or both:

- You can specify a _customer-managed key_ to use for encrypting and decrypting data in Blob Storage and in Azure Files. Customer-managed keys must be stored in Azure Key Vault or Azure Key Vault Managed Hardware Security Model (HSM).
- You can specify a _customer-provided key_ on Blob Storage operations. A client can include an encryption key on a read/write request for granular control over how blob data is encrypted and decrypted.

The following table compares key management options for Azure Storage encryption.

| Key management parameter         | Microsoft-managed keys                | Customer-managed keys                 | Customer-provided keys   |
| -------------------------------- | ------------------------------------- | ------------------------------------- | ------------------------ |
| Encryption/decryption operations | Azure                                 | Azure                                 | Azure                    |
| Azure Storage services supported | All                                   | Blob Storage, Azure Files             | Blob Storage             |
| Key storage                      | Microsoft key store                   | Azure Key Vault or Key Vault HSM      | Customer's own key store |
| Key rotation responsibility      | Microsoft                             | Customer                              | Customer                 |
| Key control                      | Microsoft                             | Customer                              | Customer                 |
| Key scope                        | Account (default), container, or blob | Account (default), container, or blob | N/A                      |

### Client-side encryption

The Azure Blob Storage client libraries for .NET, Java, and Python support encrypting data within client applications before uploading to Azure Storage, and decrypting data while downloading to the client. The Queue Storage client libraries for .NET and Python also support client-side encryption.

The Blob Storage and Queue Storage client libraries uses AES in order to encrypt user data. There are two versions of client-side encryption available in the client libraries:

- Version 2 uses Galois/Counter Mode (GCM) mode with AES. The Blob Storage and Queue Storage SDKs support client-side encryption with v2.
- Version 1 uses Cipher Block Chaining (CBC) mode with AES. The Blob Storage, Queue Storage, and Table Storage SDKs support client-side encryption with v1.

## Summary

The topics you learned about in this module included:

- Understanding Azure Blob Storage: Features, Types of Storage Accounts, and Access Tiers
- Understanding Azure Blob Storage: Storage Accounts, Containers, and Blobs
- Understanding Azure Storage Security and Encryption Features
