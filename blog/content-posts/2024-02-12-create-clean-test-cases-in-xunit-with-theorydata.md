# Create clean test cases in xUnit with TheoryData

**Date:** February 12, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/create-clean-test-cases-in-xunit-with-theorydata/

### Overview

Keeping your tests clear and readable is an important part of writing good tests, but sometimes, you may find yourself needing some more complex test cases that you find less than clean. One example I repeatedly run into that doesn't seem to lend itself to clean test cases is testing string parsing methods.

xUnit provides something solution for this called `TheoryData`, which can both help with more complicated test cases and just make your test cases cleaner in general. They say some code is worth a thousand words (or something like that, anyway), so let's take a look at an example.

### Using TheoryData

Consider that you're asked to parse a CSV file where the lines look like the comment in the following class, which you've written to parse the file:

```csharp
public record LineData(string BookName, string[] Authors, int YearPrinted, string[] Languages, string[] Subjects);

public interface IFileLineParser
{
    LineData ParseLine(string line);
}

public class FileLineParser : IFileLineParser
{
    // A line looks like this:
    // [Book Title] Author1, Author2First Author2Last, Author3; 2003; en, es, fn; Drama/Fiction/History
    public LineData ParseLine(string line)
    {
        var bookNameStart = line.IndexOf('[') + 1;
        var bookNameEnd = line.IndexOf(']');
        var bookName = line.Substring(bookNameStart, bookNameEnd - bookNameStart).Trim();
        line = line.Substring(bookNameEnd + 1);

        var authorsEnd = line.IndexOf(';');
        var authorsString = line.Substring(0, authorsEnd);
        var authors = authorsString.Split(',').Select(x => x.Trim()).ToArray();
        line = line.Substring(authorsEnd + 1);

        var yearEnd = line.IndexOf(';');
        var yearString = line.Substring(0, yearEnd).Trim();
        var year = int.Parse(yearString);
        line = line.Substring(yearEnd + 1);

        var languagesEnd = line.IndexOf(';');
        var languagesString = line.Substring(0, languagesEnd);
        var languages = languagesString.Split(',').Select(x => x.Trim()).ToArray();
        line = line.Substring(languagesEnd + 1);

        var subjects = line.Split('/').Select(x => x.Trim()).ToArray();

        return new LineData(bookName, authors, year, languages, subjects);
    }
}
```

The logic here isn't extremely complicated, but we'd still like to test it, of course. However, with all the steps involved in parsing the line, it's hard to get any of the logic tested in isolation. We could move each step of logic out into its own class to isolate it and test it individually, but then you'd end up with 5 or 6 very tiny classes instead of 1; that seems kind of overkill, doesn't it?

Integration testing will hit at least a good portion of the logic, if not all of it, but ideally, we'd have both unit and integration tests. So, what's a dev to do? Using `TheoryData` here can help cover a variety of test cases while still keeping your tests relatively clean.

Let's look at what using `TheoryData` for testing the above looks like:

```csharp
public class FileLineParserTests
{
    private readonly FileLineParser _parser = new();

    public static TheoryData<string, LineData> HappyTestCases = new()
    {
        {
            "[Very Cool Book] Bob, Daniel Ward, Julia Childs; 2003; en, es, fn; Drama/Fiction/History",
            new LineData(
                "Very Cool Book",
                new string[] { "Bob", "Daniel Ward", "Julia Childs" },
                2003,
                new string[] { "en", "es", "fn" },
                new string[] { "Drama", "Fiction", "History" }
            )
        }
    };

    [Theory]
    [MemberData(nameof(HappyTestCases))]
    public void Line_Is_Parsed_When_Formatted_Correctly(string line, LineData expectedLineData)
    {
        var actualLineData = _parser.ParseLine(line);
        actualLineData.Should().BeEquivalentTo(expectedLineData);
    }
}
```

You need to put the `MemberData` attribute on the test that you want to use the data, and that test (unsurprisingly) must also be a `Theory`. `MemberData` wants the name of the property to use, and `nameof` is a safe way of providing that. The `TheoryData` itself is flexible and you can shove whatever types you want into it, up to 10 – they just need to match up with the test's parameters. That's a nice feature, because it means `TheoryData` is type safe and prevents you from entering invalid test cases.

The `TheoryData` also needs to be `public static`, which also means that all of the data inside of it must be compile-time constants. If you want to have more varied data (which is probably pretty rare), you can use `ClassData`, which I touch on in the next section.

As seen above, I can create a fake file line with whatever data I want, then ensure that the method parses all of the parts out correctly all in one shot. If any one of the parts fail, I'll still be able to see which ones, because those parts of the expected object won't match up.

Adding another test case will help showcase the value of `TheoryData`:

```csharp
...
public static TheoryData<string, LineData> HappyTestCases = new()
{
    {
        "[Very Cool Book] Bob, Daniel Ward, Julia Childs; 2003; en, es, fn; Drama/Fiction/History",
        new LineData(
            "Very Cool Book",
            new string[] { "Bob", "Daniel Ward", "Julia Childs" },
            2003,
            new string[] { "en", "es", "fn" },
            new string[] { "Drama", "Fiction", "History" }
        )
    },
    {
        "[ Yet Another Book ] Person, George Last-Name, King Charles Jr.; 100; ; ",
        new LineData(
            "Yet Another Book",
            new string[] { "Person", "George Last-Name", "King Charles Jr." },
            100,
            new string[] { string.Empty },
            new string[] { string.Empty }
        )
    }
};
...
```

Since it's in the `TheoryData`, the test will automatically pick up the new test case. This new case tests more parsing logic for each section of the line, ensuring that the line gets parsed correctly even in the case of weird formatting.

Finally, let's add one more test to this class, which will test the lines that can't be parsed due to improper formatting:

```csharp
...
public static TheoryData<string> SadTestCases = new()
{
    "[Book name without a closing bracket Bob, Daniel Ward, Julia Childs; 2003; en, es, fn; Drama/Fiction/History",
    "[Line with ] too many; semicolons; Bob, Daniel Ward, Julia Childs; 2003; en, es, fn; Drama/Fiction/History",
    "Line missing data",
    ""
};

[Theory]
[MemberData(nameof(SadTestCases))]
public void Throws_Exception_When_Line_Is_Malformatted(string line)
{
    var parseLine = () => _parser.ParseLine(line);
    parseLine.Should().Throw<Exception>();
}
...
```

Using this, I get to test a lot of different cases without much code. Since I'm doing string testing, I also like to include what's wrong with the string in the string itself, such as "[Book name without a closing bracket." I feel pretty confident about both y tests and the code it's testing now. I could have done the same tests without using `TheoryData`, but it would have been quite ugly and hard to read.

### Bonus: using ClassData and IEnumerable

I'm calling these bonuses because I've never had a need to use anything beyond `TheoryData`, but these are good to know.

You can also use `ClassData`, which is almost the same as `TheoryData`, except – you guessed it – it's in a class! The practical difference here is that you can have data in it that's not a compile-time constant. In this example, an equivalent `ClassData` for the first test case would look like this:

```csharp
public class FileLineParserTestCases : TheoryData<string, LineData>
{
    public FileLineParserTestCases()
    {
        Add(
            "[Very Cool Book] Bob, Daniel Ward, Julia Childs; 2003; en, es, fn; Drama/Fiction/History",
            new LineData(
                "Very Cool Book",
                new string[] { "Bob", "Daniel Ward", "Julia Childs" },
                2003,
                new string[] { "en", "es", "fn" },
                new string[] { "Drama", "Fiction", "History" }
            )
        );
    }
}

...

[Theory]
[ClassData(typeof(FileLineParserTestCases))]
public void Line_Is_Parsed_When_Formatted_Correctly(string line, LineData expectedLineData)
{
    var actualLineData = _parser.ParseLine(line);
    actualLineData.Should().BeEquivalentTo(expectedLineData);
}
```

It's almost identical, but note that you use the `ClassData` attribute instead of `MemberData`. Also note that `ClassData` itself is a `TheoryData`.

You can also use `IEnumerable<object[]>` instead of `TheoryData` for both `MemberData` and `ClassData`, but I don't recommend it, as you lose type safety. For instance, here's the first test case using an `IEnumerable` instead of `TheoryData`:

```csharp
public static IEnumerable<object[]> HappyTestCases = new List<object[]>()
{
    new object[]
    {
        "[Very Cool Book] Bob, Daniel Ward, Julia Childs; 2003; en, es, fn; Drama/Fiction/History",
        new LineData(
            "Very Cool Book",
            new string[] { "Bob", "Daniel Ward", "Julia Childs" },
            2003,
            new string[] { "en", "es", "fn" },
            new string[] { "Drama", "Fiction", "History" }
        )
    }
};
```

You should mainly remember this one as an anti-pattern, favoring `TheoryData` instead.

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/xUnitTheoryData
