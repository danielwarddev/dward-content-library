# How to run every possible combination of arguments in xUnit

**Date:** October 27, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-run-every-possible-combination-of-arguments-in-xunit/

If you've ever made a test in xUnit with something like 8+ `InlineData`s and thought that there has to be a better way… Well, there is! The [Xunit.Combinatorial](https://github.com/AArnott/Xunit.Combinatorial) package by Andrew Arnott allows you to specify values in multiple `CombinatorialValues` attributes, then will run a separate test for each possible combination of those values.

It's probably easiest to look at an example. Consider the `UploadPhoto` method below:

```csharp
public async Task UploadPhoto(string fileName, byte[] fileData)
{
    if (fileData.Length > 10000)
    {
        throw new ArgumentException("File size must be under 10kb");
    }

    var fileExtension = fileName.Substring(fileName.LastIndexOf('.'));
    if (!ValidFileExtensions.Contains(fileExtension))
    {
        throw new ArgumentException("Invalid file extension");
    }

    await _photoClient.UploadPhoto(fileName, fileData);
}
```

We can easily cover all of our test cases for the argument checking with a few tests that look like this (this one being for the happy path):

```csharp
[Theory, CombinatorialData]
public async Task When_Extension_And_Size_Are_Valid_Then_Uploads_Photo_Successfully(
    [CombinatorialValues(".jpg", ".jpeg", ".png")] string fileExtension,
    [CombinatorialValues(1000, 3000, 10000)] int fileSize)
{
    var fileName = $"myFile{fileExtension}";
    var fileData = new byte[fileSize];

    await _photoService.UploadPhoto(fileName, fileData);
}
```

This single test will actually run 9 tests in total – one for each possible combination of values. Plus, if you glance at your test runner, you'll see that it shows which values were used for each run so that you know where to look if something failed.

Using `InlineData`, covering this many cases would probably be way overkill for the amount of confidence you gain in the code versus the amount of effort required to write the tests – not to mention the readability of the tests. With `CombinatorialData`, though, it's almost no effort at all, and the tests stay very readable.

We can actually even make a slight improvement to this, as well, by changing the first `CombinatorialValue` attribute – the one for the file extensions – to the following:

```csharp
[CombinatorialMemberData(nameof(PhotoService.ValidFileExtensions), MemberType = typeof(PhotoService))]
string fileExtension
```

This will have the test use the actual values from the `ValidFileExtensions` field in the `PhotoService` class. This is useful so that our tests will get updated if that field does.

### Other use cases

The CombinatorialData package offers other functionality, as well, such as `CombinatorialRandomData`, though I won't be covering those in this post. Check out its [Github repo](https://github.com/AArnott/Xunit.Combinatorial) for the docs!

### Caveat

I feel that I should note that, in my opinion, needing to use `CombinatorialData` is _possibly_ a code smell. I do believe it has valid use cases, but if you find yourself reaching for it, take a moment and ask yourself if there's not a better way to refactor either your code or your test to be cleaner and more easily testable. There may or may not be – your know your own code best.

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/xUnitCombinatorialData
