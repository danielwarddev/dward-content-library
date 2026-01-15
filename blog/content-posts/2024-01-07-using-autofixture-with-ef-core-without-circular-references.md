# Using AutoFixture with EF Core without circular references

**Date:** January 7, 2024  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/using-autofixture-with-ef-core-without-circular-references/

If you've used AutoFixture with Entity Framework before, chances are you've encountered an error like this:

> AutoFixture.ObjectCreationExceptionWithPath : AutoFixture was unable to create an instance of type AutoFixture.Kernel.SeededRequest because the traversed object graph contains a circular reference.

Or maybe this:

> Microsoft.EntityFrameworkCore.DbUpdateException : An error occurred while saving the entity changes. See the inner exception for details.
> —- Npgsql.PostgresException : 23503: insert or update on table "product_favorite" violates foreign key constraint "product_favorite_user_fk"

The first error happens because of the [navigation properties](https://learn.microsoft.com/en-us/ef/core/modeling/relationships/navigations) on the entity models – in a foreign key relationship, it's common for each model to refer to the other one in the relationship. So, if a Product model has a User property, and vice versa, that creates an endless circular reference for AutoFixture to populate, so it bails out.

The second error can have other causes, but in the case of AutoFixture being the culprit, it's because AutoFixture creates fully populated models for the navigation properties – including their primary keys that probably don't exist in the database.

What a pickle! Thankfully, there's an easy fix for these, and there's a couple of options:

-   Using AutoFixture's `Without()`
-   Using AutoFixture customizations to ignore circular references and virtual members

### 1. Using AutoFixture's Without()

This is the simpler option, though maybe a bit more cumbersome in the long run. When creating your entity with AutoFixture, use its `Build()` method and chain `Without()`s on it with whatever properties you want it to ignore. Here's an example:

```csharp
// Not using Without - will error out because of navigation properties
var product = _fixture.Create<Product>();

// Using Without - works
var product = _fixture.Build<Product>()
    .Without(x => x.ProductFavorite)
    .Without(x => x.ProductReview)
    .Create();
```

Pros:

-   No additional AutoFixture setup needed

Cons:

-   The code is more verbose
-   If more navigation properties are ever added to the model later, you'll have to go through wherever those entities are being created in your tests and add more `Without()`s for them

### 2. Using AutoFixture customizations to ignore circular references and virtual members

AutoFixture [customizations](https://autofixture.github.io/docs/fixture-customization/) allow you to change a fixture's default behavior. We can take advantage of these to tell our fixture to both not perform circular references and to ignore virtual members (which navigation properties typically are). Here's how to do that:

```csharp
public class NoCircularReferencesCustomization : ICustomization
{
    public void Customize(IFixture fixture)
    {
        fixture.Behaviors.Add(new OmitOnRecursionBehavior());
        fixture.Behaviors.OfType<ThrowingRecursionBehavior>().ToList()
            .ForEach(behavior => fixture.Behaviors.Remove(behavior));
    }
}

public class IgnoreVirtualMembersCustomization : ICustomization
{
    public void Customize(IFixture fixture)
    {
        fixture.Customizations.Add(new IgnoreVirtualMembers());
    }
}

public class IgnoreVirtualMembers : ISpecimenBuilder
{
    public object? Create(object request, ISpecimenContext context)
    {
        if (context == null)
        {
            throw new ArgumentNullException("context");
        }

        var propertyInfo = request as PropertyInfo;
        if (propertyInfo == null)
        {
            return new NoSpecimen();
        }

        if (propertyInfo.GetMethod != null && propertyInfo.GetMethod.IsVirtual)
        {
            return null;
        }

        return new NoSpecimen();
    }
}

// Somewhere in your tests where you create your Fixture
_fixture = new Fixture();
_fixture.Customize(new NoCircularReferencesCustomization());
_fixture.Customize(new IgnoreVirtualMembersCustomization());
```

Pros:

-   Setup is one-and-done and the customizations can be used (or not used) by whatever test classes need it
-   You don't have to update your tests as you add more properties to your models over time

Cons:

-   If someone doesn't realize how customizations work or know that they exist, it's not immediately obvious what's happening in the code
-   You may have a use case where you don't want to ignore all virtual members, or perhaps your navigation properties aren't virtual. In that case, you won't be able to use the customization to ignore virtual members

### Github example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/TestingWithDb
