# .NET testing practices – naming variables in tests

**Date:** April 23, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/net-testing-practices-naming-variables-in-tests/

_While I use .NET examples for this post, this testing practice is actually language-agnostic and can be carried over to any language._

Naming your variables in a clear way is an important part of any kind of code you'll write, and the code for your tests is no exception. Eventually, if you need to perform several actions in each part of arrange-act-assert in your test, tracking which values go where can take a few rereads of the test.

Consider the following fairly straightforward test:

```csharp
[Fact]
public void When_Every_File_Is_A_Txt_Then_Returns_File_Names()
{
    var directoryPath = "directoryPath";
    var fileNames = new [] { "file1.txt", "file2.txt", "file3.txt" };
    _fileSystem.Directory.GetFiles(directoryPath).Returns(fileNames);

    var result = _fileCreator.GetFileNames(directoryPath);

    result.Should().BeEquivalentTo(fileNames);
}
```

Here, we don't care so much about the mocking going on – what I want to look at is the variable names. In the past, this was a common way for me to name my variables in my tests. I'm creating some fake file names, so it makes sense that I name that array `fileNames`. Also, I'm getting the result of my system under test, so it makes sense that I call it `result`.

### Using "expected" and "actual"

In the context of arrange-act-assert, though, I don't think those carry much meaning – or, at least, we can make them carry even more meaning. Now, I like to name the object I'll be asserting on `expected`. Likewise, I like to name the object I'm asserting against `actual`. In this particular test, the test is small enough that it's not a huge change, but I think once you start to apply this everywhere and to larger tests, it helps test clarity quite a bit.

With this test, this is the new version with the variable names changed:

```csharp
[Fact]
public void When_Every_File_Is_A_Txt_Then_Returns_File_Names()
{
    var directoryPath = "directoryPath";
    var expectedFileNames = new [] { "file1.txt", "file2.txt", "file3.txt" };
    _fileSystem.Directory.GetFiles(directoryPath).Returns(expectedFileNames);

    var actualFileNames = _fileCreator.GetFileNames(directoryPath);

    actualFileNames.Should().BeEquivalentTo(expectedFileNames);
}
```

A very simple change, but when I see the word, "expected," it helps prime me to understand that the entire rest of the test will be based on asserting against that value. Likewise, when I see, "actual," I can know (without really thinking about it) that value is what I actually received from my system under test.

As this article's length shows, this is something that I believe seems minor, because it's very easy to do and understand. I think doing this small change, though, ends up making your tests a lot more readable in the long run, especially when you come back to them after a few months.
