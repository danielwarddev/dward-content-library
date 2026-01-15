# How to use enums in ASP.NET Core routes

**Date:** June 25, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-use-enums-in-asp-net-core-routes/

---

### Overview

This post will cover two things:

-   How to use an enum in ASP.NET Core routes with the string value of the enum rather than the integer value
-   How to have the Swagger UI show a dropdown of the enum values rather than needing to type in the string value

_Thanks to Nick Heath and Thomas de Wulf for their very helpful blog posts on this topic on [enum route constraints](https://nickheath.net/2019/02/20/asp-net-core-enum-route-constraints/) and [user friendly enums in Swagger](https://thomasdewulf.dev/posts/enums-net6-openapi/). This blog post is mostly a combination of those two posts, on top of me making the code (in my opinion) a bit cleaner and adding a working example._

I recently had a use case where I wanted to use an enum in my route URLs, such that the enum's name would be displayed in the route. However, by default, ASP.NET Core uses the enum's integer value, which doesn't make for a very user-friendly route.

I also wanted to show a dropdown in the Swagger UI of the values for the enum, thereby constraining the call to only valid route values, and also making it easier to use through the Swagger UI. Although this is a simplified version made for this post, the end result looks something like this:

![Screenshot of the Swagger UI showing the dropdown populated with the enum values]

### How to use enums in routes

Let's get to it. Here are the steps:

**Making ASP.NET Core handle your enum in routes**

-   Create an `IRouteConstraint`
-   Register the route constraint
-   Use the route constraint in your routes

**Creating the Swagger dropdown for the enum**

-   Create an `EnumSchemaFilter`
-   Add the filter to Swagger generator
-   Convert the enum to its string value in the route using a `JsonStringEnumConverter`

### 1. Create an IRouteConstraint

```csharp
using EnumRoutes.Controllers;

namespace EnumRoutes;

public class RouteConstraint : IRouteConstraint
{
    public bool Match(HttpContext? httpContext, IRouter? route, string routeKey, RouteValueDictionary values, RouteDirection routeDirection)
    {
        var matchingValue = values[routeKey]?.ToString();
        return Enum.TryParse(matchingValue, true, out TcgPlayerCategory _);
    }
}
```

### 2. Register the route constraint

```csharp
builder.Services.Configure<RouteOptions>(options =>
{
    options.ConstraintMap.Add("tcgPlayerCategoryEnum", typeof(RouteConstraint));
});
```

_Note: if you're using a Startup.cs file rather than just a Program.cs, this will go in the `ConfigureServices` method._

The value you choose for the token is a bit of a magic string (then again, so are the built-in ones), so treat that how you will.

### 3. Use the route constraint in your routes

```csharp
[HttpGet("{category:tcgPlayerCategoryEnum}")]
public ActionResult GetProducts([FromRoute] TcgPlayerCategory category)
{
    ...
}
```

Your enum should now work with your routes. **If you don't care about the Swagger dropdown, you're done here!**

#### 4. Create an EnumSchemaFilter

Continue with steps 4-6 if you'd also like your enum values to show up in the Swagger dropdown.

```csharp
using Microsoft.OpenApi.Any;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace EnumRoutes;

public class EnumSchemaFilter : ISchemaFilter
{
    public void Apply(OpenApiSchema schema, SchemaFilterContext context)
    {
        if (!context.Type.IsEnum)
        {
            return;
        }

        schema.Enum.Clear();
        foreach (var name in Enum.GetNames(context.Type))
        {
            schema.Enum.Add(new OpenApiString(name));
        }
    }
}
```

### 5. Add the filter to the Swagger generator

```csharp
builder.Services.AddSwaggerGen(options =>
{
    options.SchemaFilter<EnumSchemaFilter>();
});
```

_Note: if you're using a Startup.cs file rather than just a Program.cs, this will go in the `ConfigureServices` method._

### 6. Convert the enum to its string value in the route using a JsonStringEnumConverter

```csharp
builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
});
```

### A quick word of warning

When choosing to do this, ask yourself if it would not be simpler to just create multiple endpoints.

In my case, I originally had multiple controllers that had the same endpoints with the same logic, which was ultimately due to the TcgPlayer API routes. The enum allowed me to keep everything in one controller to share logic and prevent me from entering in invalid strings for which game I was querying for.

So, while adding the enum doesn't require a lot of code, it's nice to be sure that using an enum isn't a code smell for your specific situation.

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/EnumRoutes
