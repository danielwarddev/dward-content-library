# Side Income: Ecosystem Map

**Generated:** August 31, 2026
**Context:** Visual companion to [workshop-on-ramp-plan.md](workshop-on-ramp-plan.md) and [building-plan.md](building-plan.md). Nodes are deliberately terse - the reasoning lives in those two documents.

---

## The Full Picture

```mermaid
flowchart LR
    subgraph ASSETS["Content Assets"]
        Blog["daninacan.com"]
        Site["testingwithdot.net"]
        Talks["Talks + User Group"]
        Tools["Free Tools"]
    end

    subgraph AUD["Audience"]
        List["Email List"]
        Named["Named List"]
    end

    subgraph PARTNER["Partners Who Sell For You"]
        MSFT["MS Field / Dev Days"]
        OR["O'Reilly Live"]
        PreCon["Conference Pre-Cons"]
    end

    subgraph OFFERS["Offers"]
        Shop["Copilot Workshop"]
        Coach["Testing Coaching"]
        Course["Testing Course"]
    end

    Goal["$12k / year"]

    Blog --> List
    Site --> List
    Tools --> List
    Talks --> List
    Talks --> Named

    Named --> Shop
    List --> Shop
    List --> Coach
    Site --> Coach
    Site --> Course
    List --> Course

    MSFT --> Shop
    OR --> Shop
    PreCon --> Shop

    Shop --> Goal
    Coach --> Goal
    Course --> Goal

    Shop -.funds + aims.-> Tools

    classDef gap stroke-dasharray: 5 5
    class List,Tools,Course,Site gap
```

**Dashed = does not exist yet.** The email list is the biggest structural gap: four assets feed nothing.

### The build-discovery loop

```mermaid
flowchart LR
    Teach["Teach + Publish"] --> Watch["Observe Problems"]
    Watch --> Pick["Pick One"]
    Pick --> Ship["Ship Small + Free"]
    Ship --> Use["Watch Usage"]
    Use --> Charge["Charge, or Discard"]
    Charge --> Teach

    SC["Search Console"] --> Watch
```

The loop only turns if teaching keeps happening. Building alone with no teaching input breaks it at the
first step.

