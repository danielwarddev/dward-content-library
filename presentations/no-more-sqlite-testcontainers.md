# No More SQLite - How to Write Tests With EF Core Using TestContainers

# Description

Integration tests are crucial to ensuring your app's reliability. However, traditional options for writing these with EF Core, such as using SQLite or a real dev database, often introduce challenges both with maintainability and confidence - sometimes even secretly making tests pass with false positives.

This session will offer an alternative, a library called TestContainers, that addresses these challenges. After going through the more common options and the pitfalls of them, I'll introduce the TestContainers library, the benefits it offers, and demonstrate with a coding demo how to implement it in some real integration tests using EF Core.

While this talk will be made with .NET in mind and use examples in C#, the TestContainers library is offered in 10+ languages, and the knowledge can be transferred to other ecosystems. Attendees will be assumed to have basic knowledge of unit and integration testing.


# Small print

Presentation outline:
- The problem
- Traditional solutions
- 1. In-memory provider
- 2. SQLite provider
- 3. Real dev database
- 4. Containerized database with a Dockerfile
- Introducing TestContainers
- Why TestContainers?
- Coding demo (this will be the bulk of the presentation)
- Recap, closing thoughts, questions