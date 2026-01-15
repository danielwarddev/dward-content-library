# How to mock File, FileStream, Directory, and other IO calls in C#

**Date:** February 4, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-mock-file-filestream-directory-and-other-io-calls-in-c/

### The problem with static IO methods in C#

The System.IO namespace in .NET provides a lot of helpful methods to interact with a file system, but a drawback of them is that many of these methods are static. This is fine for integration testing, where you can test using real files (which probably live inside the project). However, things become problematic when trying to write unit tests that isolate business logic, in which you probably want to mock out these file system calls.

Since you can't mock static methods in C#, this presents an issue for unit testing, where you want to isolate your business logic.

### The solution – System.IO.Abstractions

You could wrap all of these calls inside interfaces to abstract them. Fortunately, there's a convenient solution which has already done just that – a Nuget package called [System.IO.Abstractions](https://github.com/TestableIO/System.IO.Abstractions). To see how to use it, let's look at an example.

Here's a simple class that reads from a file and then performs a small bit of business logic on it:

```csharp
using System.IO.Abstractions;

namespace TestingWithSystemIo;

public class MyFileWriter
{
    private readonly IFileSystem _fileSystem;

    public MyFileWriter(IFileSystem fileSystem)
    {
        _fileSystem = fileSystem;
    }

    public async Task<IEnumerable<string>> GetAllTxtFiles(string directoryPath)
    {
        // Without using System.IO.Abstractions:
        // var allFilePaths = Directory.GetFiles(directoryPath);

        var allFilePaths = _fileSystem.Directory.GetFiles(directoryPath);

        // Note that I opt to still use the static Path class here
        // It's essentially just a string helper and would be both more hassle and a little pointless to mock
        return allFilePaths.Where(x => Path.GetExtension(x) == ".txt");
    }
}
```

As seen above, the abstracted file system methods are one-for-one equivalents with the methods from the static classes.

### Mocking the file system for testing

Since `IFileSystem` is provided as an interface, mocking it becomes straightforward; you mock it the same way you would any other interface. Here's a test for the above method. It uses NSubstitute, but any mocking library will work:

```csharp
using FluentAssertions;
using NSubstitute;
using System.IO.Abstractions;

namespace TestingWithSystemIo.UnitTests;

public class MyFileWriterTests
{
    private readonly MyFileWriter _writer;
    private readonly IFileSystem _fileSystem = Substitute.For<IFileSystem>();

    public MyFileWriterTests()
    {
        _writer = new MyFileWriter(_fileSystem);
    }

    [Fact]
    public async Task GetAllTxtFiles_Returns_All_Txt_File_Paths_In_Directory()
    {
        var directoryPath = "blah";
        var expectedFilePaths = new string[] { "file.txt", "anotherfile.txt" };
        var allFilePaths = new List<string>(expectedFilePaths) { "badfile.txt.doc", "badfile.jpg" };
        _fileSystem.Directory.GetFiles(directoryPath).Returns(allFilePaths.ToArray());

        var actualFilePaths = await _writer.GetAllTxtFiles(directoryPath);

        expectedFilePaths.Should().BeEquivalentTo(actualFilePaths);
    }
}
```

Pretty slick! Likewise, you can mock any other part of System.IO with this package, such as `FileStream`, `FileInfo`, `DirectoryInfo`, and more.

### Leveraging convenience methods through extensions

There is also an extensions package, [TestableIO.System.IO.Abstractions.Extensions](https://github.com/TestableIO/System.IO.Abstractions.Extensions), which provides convenience methods with common tasks already implemented for you. For example, to get the `DirectoryInfo` for the current directory, you can use the provided one-liner `IFileSystem.CurrentDirectory()`. Explore this extension package to potentially save some time and effort on routine tasks.

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/TestingWithSystemIo
