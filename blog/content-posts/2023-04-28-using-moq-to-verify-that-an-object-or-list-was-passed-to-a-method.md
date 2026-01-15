# Using Moq to verify that an object or list was passed to a method

**Date:** April 28, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/using-moq-to-verify-that-an-object-or-list-was-passed-to-a-method/

---

_There is an NSubstitute counterpart to this post: [How to easily match on object or list arguments with NSubstitute](https://daninacan.com/how-to-easily-match-on-object-or-list-arguments-with-nsubstitute/). Click there if you would like to see how to do this using NSubstitute._

I recently had a use case where I wanted to use Moq's `It.Is` to check if a model with certain properties was being passed to a method, and also the same thing, but even worse, for a List of objects.

Instead of implementing custom logic for this, or doing a very lengthy and ugly `It.Is` with lots of checks inside of it, our team decided to instead leverage FluentAssertions' `Should().BeEquivalentTo()`. If you're curious, you can see all of the object graph comparison logic (which is pretty extensive) in the [FluentAssertions docs](https://fluentassertions.com/objectgraphs/).

A bunch of credit for this goes to Craig Wardman for his blog post, which helped me flesh out this idea in the first place. You can find that here: http://www.craigwardman.com/Blogging/BlogEntry/using-fluent-assertions-inside-of-a-moq-verify.

### Moq helper methods for object comparison

We'll put the logic inside helper methods to help keep our tests readable:

```csharp
public static class ItIs
{
    public static bool MatchingAssertion(Action assertion)
    {
        using var assertionScope = new AssertionScope();
        assertion();
        return !assertionScope.Discard().Any();
    }

    public static T EquivalentTo<T>(T obj) where T : class
    {
        return It.Is<T>(seq => MatchingAssertion(() => seq.Should().BeEquivalentTo(obj, "")));
    }
}
```

That's it! You can also make other helper methods for your own needs by utilizing the `MatchingAssertion()` method.

Ideally, we'd be able to create these as extension methods for `It`, but unfortunately, that's a static class and so can't be extended. Naming our static class `ItIs` makes it read almost the same, though.

Because this works with anything `BeEquivalentTo()` would work with, this even works for lists of objects, which is quite nice. Furthermore, because the extension method just uses FluentAssertions under the hood, you can implement even more specific checks that your use case might need, such as excluding specific properties, checking list order, and lots more.

### Example

You can use the helper methods like so:

```csharp
myService.Setup(x => x.ConcatenateIdAndDescription(ItIs.EquivalentTo(myObject))).Returns(myValue);
```

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/MoqItIsEquivalentTo
