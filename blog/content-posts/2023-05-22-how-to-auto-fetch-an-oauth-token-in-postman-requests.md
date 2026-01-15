# How to auto-fetch an OAuth token in Postman requests

**Date:** May 22, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/how-to-auto-fetch-an-oauth-token-in-postman-requests/

---

A regular annoyance when using Postman to call an API is that you'll probably need an authorization token. While you probably expect this from an API, it can be annoying to have to first make a separate request to the API's authorization endpoint, copy-paste the token into the header of your other request, and then finally make your call, especially if that token's expiration time is short.

### Pre-request scripts

Thankfully, we can automate this with Postman's pre-request scripts. A pre-request script is Javascript code that runs before a request is executed. By using this in combination with Postman variables, we can have Postman auto-fetch our token whenever it expires and insert it into our Authorization header.

**If you want to use the bearer token for a whole set of API calls, which is what this post will follow**, you'll want to create a collection if you don't have one already. Then, click the new collection and put the following script in the Pre-Request Script section of the collection.

**If you just need the bearer token for a single call**, then everything will be almost exactly the same, but you'll put values on the individual Postman request instead of the collection

Create a collection and go to the Pre-request Script tab:

### The script

_Note that I am using [Instant Web Tool's Fake Rest API](https://www.instantwebtools.net/fake-rest-api) for demonstration purposes for the script in this post, as it's free and contains an authentication endpoint. You will have to adjust the HTTP request in the script to match whatever your API's authentication endpoint expects._

Here is the pre-request script. The logic is pretty straightforward:

-   Check if the Postman variable for the bearer token has a value
-   If it doesn't, or it does but it's expired, then get a new token from the API's authentication endpoint using `pm.sendRequest()`
-   Save both the bearer token and its expiration time in variables using `pm.collectionVariables.set()`. [The pm object](https://learning.postman.com/docs/writing-scripts/script-references/postman-sandbox-api-reference/#the-pm-object) allows access to request and response data, as well as Postman variables

```javascript
// Set the Postman variable names for reuse in the script. This is what the names will show up as in the Postman editor
const bearerTokenVariableName = "bearer-token";
const bearerTokenExpirationVariableName = "bearer-expiration";

// Use the pm object to get the current stored bearer token, if any
let needNewBearerToken = false;
const currentBearerToken = pm.collectionVariables.get(bearerTokenVariableName);

// Determine if a new bearer token is needed. If there was no existing token or if the existing token has expired, a new one is needed
if (!currentBearerToken) {
    needNewBearerToken = true;
} else {
    const currentDateMillis = new Date().valueOf();
    const currentTokenExpiration = pm.collectionVariables.get(
        bearerTokenExpirationVariableName
    );
    const timeUntilTokenExpires = currentTokenExpiration - currentDateMillis;
    // I chose to refresh 1 minute before expiration here to avoid race conditions
    if (timeUntilTokenExpires <= 1 * 60 * 1000) {
        needNewBearerToken = true;
    }
}

if (!needNewBearerToken) {
    return;
}

console.log("Getting new bearer token");

// Create the request object to send for getting a new auth token from the API. Note that this requires your collection to have two parameters filled out: one for the username and one for the password
const username = pm.environment.get("username");
const password = pm.environment.get("password");
const clientId = pm.environment.get("client_id");

// This will look different depending on your API!
const getTokenRequest = {
    method: "POST",
    url: "https://dev-457931.okta.com/oauth2/aushd4c95QtFHsfWt4x6/v1/token",
    header: {
        "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
        mode: "urlencoded",
        urlencoded: [
            { key: "scope", value: "offline_access" },
            { key: "grant_type", value: "password" },
            { key: "username", value: username },
            { key: "password", value: password },
            { key: "client_id", value: clientId },
        ],
    },
};

// Send the request
pm.sendRequest(getTokenRequest, (error, response) => {
    // Log the error to the console if one occurred
    if (error) {
        console.log(
            "An error occurred when trying to retrieve a bearer token:"
        );
        console.log(err);
        return;
    }

    if (!response.code.toString().startsWith("2")) {
        console.log("Unsuccessful bearer token request:");
        console.log(response);
        return;
    }

    // Parse the token and expiration values out of the response and save them into Postman variables. The token variable can then be put into the Authorization section of the collection for automatic use in every request in the collection
    const jsonResponse = response.json();
    const bearerTokenValue = jsonResponse.access_token;
    const currentDateMillis = new Date().valueOf();
    const expiration = jsonResponse.expires_in;
    const expirationDateMillis = currentDateMillis + expiration * 1000;

    pm.collectionVariables.set(bearerTokenVariableName, bearerTokenValue);
    pm.collectionVariables.set(
        bearerTokenExpirationVariableName,
        expirationDateMillis
    );
});
```

You might also notice the `console.log()` statements – these allow us to log to Postman's console, found at the bottom left of the Postman window. It can be helpful if things go wrong or if you want to verify that it did indeed make the call.

### Creating the Postman variables for the script

In order for this script to work, you'll need to create the collection and environment variables that it references. In my example, the collection variables are `bearer-token` and `bearer-expiration`, and the environment variables are `username`, `password`, and `client-id`, since that's what Fake Rest API requires.

Environment variables will apply globally when that environment is selected, while collection variables only apply to requests in the collection.

We could put everything in collection variables, and the script would run just fine. However, collection variables can't contain secret variables; only environmental and global ones can. Creating them as secret variables will obfuscate their values in the Postman editor, which is nice for things like client secrets (granted, if you're working solo, this has little use).

**❗ Please note that secret variables are, in my opinion, of questionable use at the moment, since their values are still logged to the console as plain text when included in a request. There is currently an [open issue on Github](https://github.com/postmanlabs/postman-app-support/issues/10650) for this that hopefully comes in a future update, but at the time of this writing, it has not been changed.**

### Creating the environment variables

To create environment variables, we first need an environment. To create an environment, click on the environment tab on the left side of the Postman window and click the plus button. From here, you're plopped directly into the variables (since that's all a Postman environment is) and can create them. Change their type to "secret" in the Type dropdown to obfuscate their values.

Make sure you select the new environment from the dropdown in the top right after you create it!

If you're curious, the difference between "initial value" and "current value" is that initial values will be shared with others when sharing a collection, while current values are never synced with Postman's servers. The current value is what is actually used by Postman and will be automatically populated with the initial value if one is not set.

### Creating the collection variables

Collection variables are located in a different tab, but the process to create them is pretty much the same as it is for environment variables.

Go back to the collection tab in Postman, click on your collection, go to the Variables tab, and create the variables you need. They don't need values, as the pre-request script will be populating them.

### Using the bearer token

Lastly, we need to put that bearer token to use! Go to the Authorization tab of your collection and choose Bearer from the Type dropdown (or perhaps something else if your API is using something else), then type `{{bearer-token}}` (or whatever you named your collection variable) in the Token field.

Double curly brackets signify Postman variables. With this, it will populate the Authorization header with the token fetched from the pre-request script, which will run on every request executed in the collection.

You can see for yourself by going to a request in the collection and going to the Authorization tab for that request.

Now, when you run the request and look at the Postman console, you should not only see the logs from the request we actually ran, but also the logs from our pre-request script.

You're done! Your requests will now be automatically authenticated by Postman. Collections, variables, and scripts have more use outside of just what's laid out in this post, so I hope you find other things in Postman from this that continue to make your life easier.
