# How to mock ClaimsPrincipal in C#

**Date:** March 18, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-mock-claimsprincipal-in-c/

If you've ever tried to mock out claims in C# with something like Moq or NSubstitute, you may have already gone through trying to mock `HttpContextBase`, then `ClaimsPrincipal`, then finally `ClaimsIdentity` with some `Claim`s. As you can see just from that alone, it's a bit of a hassle to chain all the mocking to finally get to the actual claims that you want to mock out.

While you can do this in Moq, NSubstitute, or your faking library of choice, it's actually much easier and shorter to do this manually, rather than wrestling with those multiple layers of mocks. Let's take a look at that.

### How to mock claims the easy way

Here's a quick snippet showing how to set up fake claims an easier way:

```csharp
_controller.ControllerContext.HttpContext = new DefaultHttpContext
{
    User = new ClaimsPrincipal(new ClaimsIdentity(new[]
    {
        new Claim(ClaimTypes.Role, "admin")
    }, "fake auth"))
};
```

As you can see, all you need to do is manually create the claims that are nested inside of the controller's context. This works and ends being a lot easier and cleaner than mocking the calls all the way down.

Of course, you can include whatever claims you want in there. Since it's a tad wordy, it might be nice to use an extension method for it, as well:

```csharp
public static class TestExtensions
{
    public static void InitializeClaims(this Controller controller, params Claim[] claims)
    {
        controller.ControllerContext.HttpContext = new DefaultHttpContext
        {
            User = new ClaimsPrincipal(new ClaimsIdentity(claims, "fake auth"))
        };
    }
}

// In use
_controller.InitializeClaims(new Claim(ClaimTypes.Role, "admin"));
```

That's it! Your claims will be mocked out in your tests now.

❗ **Important note**: you must provide a value to `authenticationType` if you want `HttpContext.User.Identity.IsAuthenticated` to be true in your tests (any string will work). It's not required to just mock the claims out like we're doing here, but for most tests, you're probably going to want the user to be authenticated.

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/MockClaimsPrincipal
