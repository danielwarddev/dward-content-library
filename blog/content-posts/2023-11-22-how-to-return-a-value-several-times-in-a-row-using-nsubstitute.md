# How to return a value several times in a row using NSubstitute

**Date:** November 22, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-return-a-value-several-times-in-a-row-using-nsubstitute/

I was recently writing some tests that had a mocked method that I wanted to return the same value several times in a row from. It turns out, NSubstitute can do this out of the box. While `Returns` takes a value `T`, if you look at its method signature, you'll see it takes another argument after that, `params T[]`. In this case, this is exactly what we want – it will return these values in sequence whenever the mocked method is called. However, I ended up with something like this:

```csharp
_myService.MyMethod(Arg.Any<string>())
    .Returns(
        "some value",
        "some value",
        "some value",
        "some value",
        "some value",
        string.Empty);
```

This does what I want, but it's not the prettiest bit of code, and I thought that it made my tests a little harder to read. I'm doing the same thing over and over, so can't I just pass it an integer for how many times I want it to return?

Well, not out of the box, unfortunately. It's not too hard to make an extension method to do that, though:

```csharp
public static class TestHelpers
{
    public static ConfiguredCall ReturnsConsecutive<T>(
        this T value,
        int timesToReturn,
        T returnValue,
        T returnValueAfter)
    {
        if (timesToReturn < 0)
        {
            throw new ArgumentException("Value must be non-negative", nameof(timesToReturn));
        }

        var returnValues = Enumerable
            .Repeat(returnValue, timesToReturn - 1)
            .Append(returnValueAfter)
            .ToArray();

        return value.Returns(returnValue, returnValues);
    }
}
```

Using it is a bit cleaner than the previous version:

```csharp
_myService.MyMethod(Arg.Any<string>()).ReturnsConsecutive(5, "some value", string.Empty);
```

Keep in mind that, just like any other `Returns` calls in NSubstitute, this will override any existing return values you have for the specified arguments. I found that I needed `returnValueAfter` if I didn't want NSubstitute to keep giving me the same return value indefinitely.

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/NSubstituteReturnsConsecutive
