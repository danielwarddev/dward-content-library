# Naming conventions for tests in C#

**Date:** May 9, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/naming-conventions-for-tests-in-c/

So, you're writing automated tests (hopefully). Maybe your team can't agree on how to name tests, or maybe you're working solo and not sure the common conventions other people are working with. Plus, naming tests can be hard, and following some guidance can be helpful in figuring out good test names.

In my opinion, good test names really comes down to only satisfying two things:

-   Clearly state what the test doing
-   The whole team agrees on doing it that way

Aside from that, there's a lot of freedom in choosing what you like best. I don't really want to make it sound like I endorse or dislike any of these options, either. I have my own preferences, but I think these are all fine choices.

That being said, if you're curious, I currently use a combination of option #2 and #3, using the given-when-then format, but with plain English using underscores.

### 1. UnitOfWork_StateUnderTest_ExpectedBehavior

This pattern was suggested by Roy Osherove in his popular book, [The Art of Unit Testing](https://www.artofunittesting.com/), first published in 2006. Usually, the unit of work will be a method name, but it doesn't necessarily have to be.

Example: `AddProduct_ProductNameExists_ThrowsException` or `AddProduct_ProductNameDoesNotExist_Succeeds`

### 2. Given, when, then

This is a BDD-style naming convention, and works just as well for plain old non-BDD tests. While the "given" part can be part of the test name, it's often stated in the name of the test class (or subclass), since that precondition applies to all tests inside of the class. See more info [in Martin Fowler's post](https://martinfowler.com/bliki/GivenWhenThen.html).

Example: `Given_ProductDoesNotExist_When_AddProduct_Then_ThrowsException`

### 3. Plain old English with underscores instead of spaces

As far as I know, this doesn't have any kind of name, but I think it's a viable option. While I would like if C# could do what some other languages do and use actual strings for the test names, this is pretty close. You can also just use one of the other options with this, as well, such as with given, when then.

Example: `Adding_A_Product_That_Doesnt_Exist_Throws_An_Exception`

### 4. xUnit's DisplayName

xUnit's DisplayName allows us to use a string for the test name, which lets us use normal English for test names. Then, when you run your tests, the output will show the string in the `DisplayName` attribute, rather than the test function's name.

This is similar to the above in that we can use it with another naming style, such as given, when, then.

Note that a potential caveat here is that you now need to decide what to do with the actual function name. We can see one option in the real world from [bUnit](https://github.com/bUnit-dev/bUnit), a popular Blazor testing library (just search the repo for "DisplayName"). That repo uses DisplayName for the test names, then just names the actual functions things like `Test001()`.

Example: `[Fact(DisplayName="Given the product does not exist, when AddProduct is called, throw an exception")]`

### 5. xUnit's config file

This is one I've not messed with, just because it never seemed worth the hassle. However, maybe others have found it useful.

[xUnit's xunit.runner.json config file](https://xunit.net/docs/configuration-files) allows you to do many things, including specify how the method names for tests will be displayed when you run them. I won't detail how to do that here, but it allows you to use spaces and special characters in test names.

For instance, with the `replaceUnderscoreWithSpace` and `useOperatorMonikers` values, transformations like the following are possible:

Method name: `When_product_cost_is_ge_100_then_add_discount()`

Displayed test name when ran: `When product cost is >= 100 then add discount`
