# How to test and mock IAsyncEnumerable in C#

**Date:** August 15, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-test-and-mock-iasyncenumerable-in-c/

**_This is part 2 in a 2-part series:_** _Part 1: [How to use IAsyncEnumerable in C# for paged APIs](https://daninacan.com/how-to-use-iasyncenumerable-in-c-for-paged-apis/). Part 2: How to test and mock IAsyncEnumerable in C#_

Note that this post, like the last one, will use the use case of making HTTP calls, but the same logic in it will hold true for any async calls being made.

In theory, mocking paged HTTP responses is exactly the same as mocking any other HTTP response: create a fake response, tell the mocked `HttpMessageHandler` to return that response when a specific endpoint is hit, then test any logic from there. In practice, it's a bit more cumbersome, because to write a good test that makes sure your logic is working correctly, you probably want the call to be made a few times with a few fake pages, which entails more mocking.

Using the same function from the previous post, I'll cover two things here: how to mock the HTTP calls the client class is making and how to mock the client class from a service that's consuming it.

As a reminder, here is the client class from the previous post we'll be testing. It continues to make requests to the API until we have at least as many records as specified in the `Count` value the API gives us in its responses:

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

### How to mock multiple async responses to return an IAsyncEnumerable

Here is the test file for `PokemonClient`:

```csharp
public class PokemonClientTests
{
    private readonly Fixture _fixture = new();
    private readonly PokemonClient _pokemonClient;
    private readonly Mock<HttpMessageHandler> _httpMessageHandler = new();
    private readonly string _baseAddress = "https://www.google.com";

    public PokemonClientTests()
    {
        var httpClient = new HttpClient(_httpMessageHandler.Object) { BaseAddress = new Uri(_baseAddress) };
        _pokemonClient = new PokemonClient(httpClient);
    }

    [Fact]
    public async Task Returns_Pages_Until_Results_Is_Greater_Than_Or_Equal_To_The_Total_Count()
    {
        var endpoint = $"{_baseAddress}/pokemon";
        var totalPages = 3;
        var resultsPerPage = 3;
        var responses = SetupSuccessfulPagedResponses<PokeApiInfoUrl>(endpoint, totalPages, resultsPerPage);
        var expectedResults = responses.Select(x => x.Results).ToArray();

        int i = 0;
        await foreach (var actualResults in _pokemonClient.GetAllPokemon())
        {
            expectedResults[i].Should().BeEquivalentTo(actualResults);
            i++;
        }
    }

    private List<PokeApiResponse<T>> SetupSuccessfulPagedResponses<T>(string endpoint, int totalPages, int resultsPerPage)
    {
        var responses = new List<PokeApiResponse<T>>();
        for (int i = 0; i < totalPages; i++)
        {
            var response = SetupSuccessfulResponse<T>(endpoint, resultsPerPage, totalPages * resultsPerPage, PokemonClient.PageSize, i * PokemonClient.PageSize);
            responses.Add(response);
        }
        return responses;
    }

    private PokeApiResponse<T> SetupSuccessfulResponse<T>(string endpoint, int resultsPerPage, int countInResponse, int limit, int offset)
    {
        var results = _fixture.CreateMany<T>(resultsPerPage).ToArray();
        var response = new PokeApiResponse<T>(countInResponse, null, null, results);

        _httpMessageHandler
            .SetupSendAsync(HttpMethod.Get, $"{endpoint}?limit={limit}&offset={offset}")
            .ReturnsHttpResponseAsync(response, HttpStatusCode.OK);

        return response;
    }
}
```

Creating a fake response (which is one page) isn't too hard. We just need to make sure the response's Count property matches up with the number of results we give it. This is what the `SetupSuccessfulResponse` helper is for. The other helper, `SetupSuccessfulPagedResponses`, merely calls that multiple times to create several pages.

Because the mocked HTTP handler will throw an exception if it receives a request that wasn't set up, this will effectively test the business logic that quits the processing once we have results greater than or equal to the `Count` value in the responses.

### How to mock an IAsyncEnumerable in a consuming service

Now, let's test the other direction – how to mock responses from our `PokemonClient` for a class that's consuming it. In our case, that will be the `PokemonService` from the previous post. Here it is as a reminder:

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
        var pokemon = new List<PokeApiInfoUrl>();
        await foreach (var page in _pokemonClient.GetAllPokemon())
        {
            pokemon.AddRange(page);
            if (pokemon.Count >= amount)
            {
                break;
            }
        }
        return pokemon;
    }
}
```

Note that the service will add the entire page to the list, even if it goes a little over the requested amount. So, we can say it gets _at least_ the requested amount if the API has that many.

Testing this is pretty easy thanks to the `ToAsyncEnumerable` LINQ extension method. You need to have the [System.Linq.Async](https://www.nuget.org/packages/System.Linq.Async) Nuget package in your project to access it, but it comes from the normal System.Linq namespace once you do.

`ToAsyncEnumerable` will take a normal `IEnumerable` and turn it into an `IAsyncEnumerable`. It will do this by executing a separate yield return for each value in the collection, not one yield return for the entire collection.

You could also create your own `IAsyncEnumerable` by creating an async helper function with yield returns in it.

With that in mind, here's the test code for `PokemonService`:

```csharp
public class PokemonServiceTests
{
    private readonly Fixture _fixture = new();
    private readonly PokemonService _pokemonService;
    private readonly Mock<IPokemonClient> _pokemonClient = new();

    public PokemonServiceTests()
    {
        _pokemonService = new PokemonService(_pokemonClient.Object);
    }

    [Theory]
    [InlineData(1, 3)]
    [InlineData(8, 9)]
    [InlineData(12, 12)]
    public async Task Makes_Calls_To_Client_Until_It_Has_Requested_Amount(int requestedAmount, int expectedAmount)
    {
        var allUrlPages = _fixture.CreateMany<PokeApiInfoUrl[]>();
        _pokemonClient.Setup(x => x.GetAllPokemonUrls()).Returns(allUrlPages.ToAsyncEnumerable());
        var expectedUrls = allUrlPages.SelectMany(x => x).Take(expectedAmount);

        var actualUrls = await _pokemonService.GetPokemonInfoUrls(requestedAmount);

        actualUrls.Should().BeEquivalentTo(expectedUrls);
    }

    // Example of how to create your own async enumerable if you don't want to use ToAsyncEnumerable
    private async IAsyncEnumerable<PokeApiInfoUrl[]> CreateAsyncEnumYield()
    {
        yield return _fixture.Create<PokeApiInfoUrl[]>();
        yield return _fixture.Create<PokeApiInfoUrl[]>();
        yield return _fixture.Create<PokeApiInfoUrl[]>();
        await Task.CompletedTask;
    }
}
```

By default, [Autofixture](https://github.com/AutoFixture/AutoFixture) will create three values for collections. Since we're calling a `CreateMany` for an array, we're going to create three arrays, each with three values in them. Since I don't want to bother with customizing this for a simple test, we'll just work in multiples of 3 because of it.

For instance, if we request only 1 value, then the service will take the entire first page of 3 values, save it, then return that, so we should expect 3 values, as shown in the `InlineData`, and so on for the other cases. Really, though, the main point is to illustrate how to mock an `IAsyncEnumerable`, so don't worry about the specifics of this business logic too much.

### Github Example

You can find a full working example of this at the following Github repository: https://github.com/danielwarddev/AsyncEnumerable
