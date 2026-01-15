# How and why to write mutation tests in C#

**Date:** December 14, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-and-why-to-write-mutation-tests-in-c/

🎄 _This post was made for the [2024 C# Advent Calendar](https://www.csadvent.christmas/). Check out the other posts there!_

_Your engineering director, Santa, has noticed your tests are not passing and is very upset with you. He has threatened you with the naughty list, so you better fix them fast!_

---

### Overview

Mutation testing isn't something I have personally seen much in .NET projects, including my own. In fairness, if a team has difficulty finding time to write any tests at all, mutation testing is probably something that should take a backseat to having some tests written in the first place. However, for projects with a minimum amount of coverage already (whatever that means) and teams that are already familiar with testing, mutation testing is a good tool to bring your confidence level in your project even higher.

### What is mutation testing?

In short, mutation testing is way to test your tests. It involves "mutating" your code by tweaking it in small ways. These new behaviors are appropriately called "mutants," and since they now behave differently from your expected production code, your tests should be able to accurately detect these new, undesired behaviors by failing. If they do, this is called "killing" a mutant. Otherwise, mutation testing has found a test that doesn't actually verify what you thought it did! In that case, the test should be updated to correctly perform its assertion.

Mutation testing helps us benchmark our tests by answer a very important question: **if I were to change my code so that it's doing something different, would a test fail because of that?** If a test doesn't fail, that's reason to ask yourself if it needs to be changed.

### Stryker for C#

Stryker is a mutation testing library for C# (and other languages) and the one we'll be using in this post. You can check out [the docs here](https://stryker-mutator.io/docs/stryker-net/introduction/) and [the Github page here](https://github.com/stryker-mutator/stryker-net).

Stryker is a [.NET tool](https://learn.microsoft.com/en-us/dotnet/core/tools/global-tools), which just means it's a Nuget package that also comes with a console app. You can install a .NET tool globally for your machine's user or locally to a single project. The advantage to a local install is that anyone who clones the repo will be able to run the Stryker commands, even if they haven't globally installed Stryker.

The local install is the one I recommend, since it'll probably make it easier to work with a team all using Stryker. Regardless, here are both options:

-   **Local install:** `dotnet new tool-manifest` then `dotnet tool install dotnet-stryker`. Be sure to check the new `dotnet-tools.json` file into source control.
-   **Global install:** `dotnet tool install -g dotnet-stryker`

### A very festive example service

Since this post is being done for [2024 C# Advent of Code](https://www.csadvent.christmas/), we, of course, have to include some elfy logic in here. For that, I've made a very festive `ElfCalculator` class, which… Okay, it's pretty much some math logic with elves instead. That's festive enough for me. Here's the simple logic we'll be testing:

```csharp
public class ElfCalculator
{
    public int AddElves(int elf1, int elf2)
    {
        return elf1 + elf2;
    }

    public bool LastElfIsEven(IEnumerable<int> elves)
    {
        return elves.Last() % 2 == 0;
    }

    public int AddStringyElves(string elf1, string elf2)
    {
        if (string.IsNullOrWhiteSpace(elf1) || string.IsNullOrWhiteSpace(elf2))
        {
            throw new ArgumentException("Elves cannot be null or empty");
        }
        return int.Parse(elf1) + int.Parse(elf2);
    }
}
```

Who doesn't want some stringy elves in their codebase? Of course, like all good little elves developers, we've written a suite of tests to go along with it. They are also quite simple. Here's what they look like:

```csharp
public class ElfCalculatorTests
{
    private readonly ElfCalculator _calculator = new();

    [Fact]
    public void AddElves_Adds_Correctly()
    {
        var result = _calculator.AddElves(1, 0);
        result.Should().Be(1);
    }

    [Fact]
    public void LastElfIsEven_Returns_True_When_Last_Elf_Is_Even()
    {
        var result = _calculator.LastElfIsEven(new List<int> { 2 });
        result.Should().BeTrue();
    }

    [Fact]
    public void When_Strings_Are_Numbers_Then_AddStringyElves_Adds_Correctly()
    {
        var result = _calculator.AddStringyElves("1", "1");
        result.Should().Be(2);
    }

    [Fact]
    public void When_Strings_Are_Empty_Then_AddStringyElves_Throws_ArgumentException()
    {
        var action = () => _calculator.AddStringyElves("", "");
        action.Should().Throw<ArgumentException>().WithMessage("Elves cannot be null or empty");
    }
}
```

Hey, we've even got a report of 100% code coverage from [dotCover](https://www.jetbrains.com/dotcover/)! Our manager (Santa, obviously) will surely be happy about that.

Does that mean zero bugs, though? Let's move on to actually running Stryker.

### Running Stryker

We can run Stryker by running `dotnet stryker`. We get some nice-looking CLI output containing our results at the end:

At the bottom, we can see that our mutation score was 80%, which means that we didn't kill all the mutations. You'll also see a path to a file it generated, which is a pretty HTML report of the mutation test run.

❗ An important note – you might also notice that, **even with only 4 unit tests, Stryker still took 16 seconds to run!** This isn't really a fault with Stryker – mutation testing in general just takes longer than unit testing. However, it does mean that you may choose not to run Stryker with the same frequency as your unit tests. For instance, you may choose to run it in your pipeline before merging/deploying, and not worry about it otherwise.

### Investigating Reports

Let's open up that HTML report file.

The HTML report shows a prettified view of all the files it analyzed, along with the results for each one. In our case, we only have one file, ElfCalculator.cs, so let's click on it.

Here, we can see the surviving mutations – the ones our tests didn't kill. If we click on them, we can see the reasons they failed. Let's look at the first one inside `AddElves()`.

Now, we finally get to the meat of what mutation testing does. In this case, Stryker has tweaked an arithmetic operator from + to -. Clearly, this fundamentally changes the logic of our function, so our tests should fail. However, they still passed! This means our code might be correct, but our tests are bad. Let's investigate why. As a reminder, here's the test for `AddElves()`:

```csharp
[Fact]
public void AddElves_Adds_Correctly()
{
    var result = _calculator.AddElves(1, 0);
    result.Should().Be(1);
}
```

Since we gave it 1 and 0 for arguments, both addition and subtraction will result in 1, which is why the mutation wasn't killed. This is a signal that we could probably choose better values for our test – or, sometimes, multiple cases with an xUnit Theory.

For now, in the test, let's just change the parameters to 3 and 4, and the assertion to 7. Run `dotnet stryker` again, then open up the HTML report:

Success! Our score is now 86.67%, `AddElves()` no longer has any red lines, and we can see that the killed count has gone up to 13, while the survived count has been bumped down to 2.

### Fixing all the mutations

We still have 2 more mutations to cover, and you can click on the red circles to view each one. For brevity, here they all are together:

The first is a LINQ mutation – `Last()` was changed to `First()`. Again, even though this is a very different operation, our test still passed. Here's the test for that method:

```csharp
[Fact]
public void LastElfIsEven_Returns_True_When_Last_Elf_Is_Even()
{
    var result = _calculator.LastElfIsEven(new List<int> { 2 });
    result.Should().BeTrue();
}
```

The reason the mutation wasn't killed was, again, because of bad test data. We passed a list with only one value, which is why `First()` and `Last()` had the same behavior. We can fix this by just passing another value into the list initializer. If we give it 1 then 2, instead of just 2, then our test will now kill this mutation.

The second mutation was a logical operator change, where it changed || to &&, but our test still passed anyway. Here's the test for that method:

```csharp
[Fact]
public void When_Either_String_Is_Empty_Then_AddStringyElves_Throws_ArgumentException()
{
    var action = () => _calculator.AddStringyElves("", "");
    action.Should().Throw<ArgumentException>().WithMessage("Elves cannot be null or empty");
}
```

Although this is desired behavior, it signals missed test cases. We can change this test to an xUnit Theory and cover cases where only the first parameter is empty, and the same for the second.

After all these changes, let's run Stryker one more time…

100%! All green (and not having to be on call) is a nice present under the tree for ourselves.

### Closing up – look into Stryker more!

If you like, you can look at the Github example below to see the modified tests.

The Stryker docs are quite good, and the tool itself has a lot to offer outside of what was shown here. For example, you can see [all the different kinds of mutations here](https://stryker-mutator.io/docs/stryker-net/mutations/), such as initialization, Linq methods, and regular expressions. All the mutations performed in this post can be seen there, and more. You can change the reporter, use it in a pipeline, and more. So, go forth and kill some mutants.

### Github example

You can find a full working example of this at the following Github repository: [https://github.com/danielwarddev/MutationTestingStrykerCSharp](https://github.com/danielwarddev/MutationTestingStrykerCSharp)
