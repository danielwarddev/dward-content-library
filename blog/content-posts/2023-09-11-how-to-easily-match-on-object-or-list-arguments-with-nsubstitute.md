# How to easily match on object or list arguments with NSubstitute

**Date:** September 11, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-easily-match-on-object-or-list-arguments-with-nsubstitute/

_There is a Moq counterpart to this post: [Using Moq to verify that an object or list was passed to a method](https://daninacan.com/using-moq-to-verify-that-an-object-or-list-was-passed-to-a-method/). Click there if you would like to see how to do this using Moq._

### Overview

Sometimes, when using `Arg.Is()`, we would like the argument to look like a certain object, or worse, a list of objects. Perhaps we would like it to look like an object, but ignore some of the properties. These things are possible with `Arg.Is()`, but they are quite ugly, brittle, and usually require many lines of code.

There is a better way, which is to leverage [FluentAssertions](https://fluentassertions.com/)'s `BeEquivalentTo()`. If you're not familiar with FluentAssertions, it's merely a set of extension methods made to make asserting more readable. In my opinion, `BeEquivalentTo()` is the most useful method it ships with. It has a _very_ extensive [page on its docs about how that method performs its object graph comparison](https://fluentassertions.com/objectgraphs/) if you're curious.

We would normally use `BeEquivalentTo()` something like this:

```csharp
actualValue.Should().BeEquivalentTo(expectedValue);
```

Okay, great. So, how does that help us here? Well, please calm down and I'll show you.

### NSubstitute helper methods for object comparison

The long and short of is that we can create an `AssertionScope` inside of an `Arg.Is()`, run whatever actions we want inside of the scope, and then check if the scope has any failures.

A demonstration will probably explain it better. Here are the extension methods I use and how I use them:

Extension methods:

```csharp
public static class ArgIs
{
    // This is just public in case you want to create custom ones in your tests
    // Or, you could make it private and create new extension methods utilizing it
    public static bool MatchingAssertion(Action assertion)
    {
        using var assertionScope = new AssertionScope();
        assertion();
        return !assertionScope.Discard().Any();
    }

    // This is the method we will be using
    public static T EquivalentTo<T>(T value) where T : class
    {
        return Arg.Is<T>(arg => MatchingAssertion(() => arg.Should().BeEquivalentTo(value, string.Empty)));
    }
}
```

Using them would look something like:

```csharp
myService.Setup(x => x.SomeMethod(ArgIs.EquivalentTo(someObject))).Returns(expectedValue);
```

Notice that I was a little cute with the class name `ArgIs`. You can't extend `Arg`, since it's static, so `ArgIs` still reads pretty similarly.

### A note on list types

This is also explained in a comment in the example Github repo in the LotteryServiceTests, if you prefer to look at the code.

Although it isn't specific to these methods, there is a bit of a gotcha with using any `Arg.Is()` calls on list types, and it has to do with type inheritance, rather than this `Arg.Is()` itself. I thought I would mention it since it's easy to overlook.

Consider that you are passing an IEnumerable into a method in your real code. In your tests, you've created a List that you expect the passed in argument to be equivalent to. The compiler lets you do this, since a List is an IEnumerable. However, the assertion will fail. This is because `Arg.Is()` is really `Arg.Is<T>()`, where the T is usually inferred by the object you pass in. That means if you pass in a List, it will be looking specifically for a List to match on. An IEnumerable is not a List, so it fails. It would work, however, if you specify the T as IEnumerable (although your IDE may tell you this is redundant), create an IEnumerable instead of a List, or if you cast the object to T inside the extension method. You could also do none of these and instead opt to just be mindful of your testing data.

Take whatever route is easiest for you; I just thought this was something worth noting.

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/NSubstituteArgIsEquivalentTo
