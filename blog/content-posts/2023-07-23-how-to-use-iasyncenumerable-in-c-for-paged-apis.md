# How to use IAsyncEnumerable in C# for paged APIs

**Date:** July 23, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-use-iasyncenumerable-in-c-for-paged-apis/

**_This is part 1 in a 2-part series:_** _Part 1: How to use IAsyncEnumerable in C# for paged APIs. Part 2: [How to test and mock IAsyncEnumerable in C#](https://daninacan.com/how-to-test-and-mock-iasyncenumerable-in-c/)_

Ever since C# 8, we've been able to create asynchronous enumerables using `IAsyncEnumerable`. This is a handy feature to have when the work being done to enumerate over the collection is itself asynchronous work.

My personal example for this, that I assume is also a more common one, is calling an API that returns paged results, where you can't be sure in advance how many pages there will be, but you want to process all of them. Another case might be using the `DeserializeAsyncEnumerable()` method of `JsonSerializer` for reading from streams, such as those from files.

For the examples of how to create and consume one, I'll use [PokéApi](https://pokeapi.co/), as it's free and has paginated endpoints.

Here's an example class with a method that returns paged results:

```csharp
public class PokemonClient : IPokemonClient
{
    public const int PageSize = 100;
    private readonly HttpClient _httpClient;

    public PokemonClient(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async IAsyncEnumerable<PokeApiInfoUrl[]> GetAllPokemonUrls()
    {
        await foreach (var pageResults in GetAllPages<PokeApiInfoUrl>("pokemon"))
        {
            yield return pageResults;
        }
    }

    private async IAsyncEnumerable<T[]> GetAllPages<T>(string endpoint)
    {
        int? totalCount = null;
        int currentCount = 0;
        var currentPage = 0;

        do
        {
            var response = (await _httpClient.GetFromJsonAsync<PokeApiResponse<T>>(
                $"{endpoint}?limit={PageSize}&offset={currentPage * PageSize}"))!;

            totalCount = totalCount ?? response.Count;
            currentCount += response.Results.Length;
            yield return response.Results;
            currentPage++;
        } while (totalCount > currentCount);
    }
}
```

Consuming the paged results might look something like this:

```csharp
public class PokemonService : IPokemonService
{
    private readonly IPokemonClient _pokemonClient;

    public PokemonService(IPokemonClient _pokemonClient)
    {
        this._pokemonClient = _pokemonClient;
    }

    public async Task<List<PokeApiInfoUrl>> GetPokemonInfoUrls(int amount)
    {
        var pokemonUrls = new List<PokeApiInfoUrl>();
        await foreach (var page in _pokemonClient.GetAllPokemonUrls())
        {
            pokemonUrls.AddRange(page);
            if (pokemonUrls.Count >= amount)
            {
                break;
            }
        }
        return pokemonUrls;
    }
}
```

Of course, you could tweak the logic to do things like take in the maximum number of calls that should be made as a parameter or set the limit and offset, but that's the gist of it!

This post is intended to be a quick and easy example to show you how to get up and running with `IAsyncEnumerable`. For a great series of posts that goes deeper into it, Mark Heath has a 3-part series on it titled [Async Enumerable in C#](https://markheath.net/post/async-enumerable-1). Check it out if you're interested in going a bit deeper on the topic and finding out it and more things you can do with it, such as extension methods (not affiliated or anything, it's just a nice set of posts on the topic that I found).

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/AsyncEnumerable
