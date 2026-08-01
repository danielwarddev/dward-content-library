### Overview

JetBrains recently released ReSharper on the [Open VSX registry](https://open-vsx.org/extension/JetBrains/resharper-code), which is pretty big news, in my opinion. If you're not familiar with Open VSX, it boils down to this: it's essentially the same service as the extension marketplace in VS Code, but unlike that one, which is VS Code only, it works with any VS Code-compatible editor (including VS Code itself).

Practically, this means that **all those other IDEs that are VS Code forks that use the Open VSX marketplace also now get ReSharper**. This includes:

- VS Code (this actually already had ReSharper through the Visual Studio marketplace, not the Open VSX one, but I'm listing it for knowledge sake)
- VSCodium
- Cursor
- Windsurf
- Kiro
- Antigravity
- GitLab's Web IDE
- Probably more I didn't list here

This post will mostly be about looking at the features ReSharper has in its Open VSX version. Let's see what it can do!

### Why should I use ReSharper in these IDEs?

There are two main reasons I can think for why you might want to use ReSharper on Open VSX.

Firstly, the advent of AI tools in coding: if you look at the list of IDEs above, most of them are AI-focused ones. However, if you code in C#, they're also not great choices since they don't have much support for C# or .NET in general. This leads to a bit of an awkward situation where you need to keep open your "actual" coding IDE with C# support, as well as your "other" AI-focused IDE when using AI. This helps bridge that gap.

Secondly, if you're in an environment where you either can't or prefer not to use one of the more popular .NET IDEs, this gives you more options. If, for instance, you're a big supporter of open projects and don't like telemetry, you might want to use VSCodium, and this makes it easier to do that. Or, if your company mandates Kiro, this makes that easier to use with C#, as well.

### Free vs. premium license

The free version of ReSharper actually comes with all of the features that the premium version does. The difference is that, as JetBrains says on the extension page, "if you're paid for your development work, or your project is intended to generate commercial benefits, you'll need a commercial license."

You can find the ReSharper premium pricing options [on this page on the JetBrains site](https://www.jetbrains.com/resharper/buy/?section=personal&billing=yearly).

### Installing ReSharper

There's nothing weird about the install; just search for "resharper" in the marketplace, make sure the identifier for the extension is `jetbrains.resharper-code`, and then log in with your JetBrains account once it's installed.

One thing to note is that Open VSX limits extension size to 256 MB. Since ReSharper was bigger than this, JetBrains got around this by having the extension itself be quite small (around 8MB), and instead, do a one-time download of its features from their servers when you first install it.

This is perfectly fine, but I wanted to point it out in case you wonder what that "Getting ready" message is doing for a whole minute or so.

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-getting-ready.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-getting-ready.jpg)

### ReSharper features in Open VSX

Here, I'll cover many of the features for ReSharper I think are quite useful. However, I want to note that **this is not a comprehensive list of every feature!**

Also, just to make things easier on myself and avoid taking a ton of screenshots, all of the screenshots in this blog post will be from Kiro. However, the UI will be extremely similar or the same across the other supported IDEs.

#### Solution Explorer

Once you install ReSharper and sign in, you'll see it ask you to pick a solution file to open. Once you do that, navigate to a new view in your Explorer tab, the ReSharper solution explorer.

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-solution-explorer.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-solution-explorer.jpg)

This is the same explorer view you'd be used to from Visual Studio or Rider, which is nice. The default view is still available, as well, and in this screenshot it's simply collapsed.

#### Adding new projects

In this new section, we can right-click the solution name to add a new project.

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-add-project.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-add-project.jpg)

Doing so gives us a list of project templates, and we can create a new project as normal.

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-add-project-templates.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-add-project-templates.jpg)

You can add solution folders from here, as well!

#### NuGet package manager

This solution explorer view also comes with a NuGet package manager.

Under each project, you'll see a "Dependencies" item, which can be right-clicked to either install packages or add project references.

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-add-package.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-add-package.jpg)

This is definitely nice to have, though it's not quite as nice as the one you'd find in Visual Studio or Rider. When searching for packages to install, you don't get any information about it other than the name and version (no author, README, repo link, etc.).

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-package-search.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-package-search.jpg)

Also, in order to update or uninstall packages, you'll need to right-click on the package name by expanding the Dependencies item and selecting either "Update Package" or "Uninstall Package".

#### General coding assistance & code analysis

The many code analysis tools and recommendations are arguably the biggest value add of the extension. There are far, far too many of these features to list here, but I'll give a few examples.

***Quick documentation on hover:***

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-quick-docs.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-quick-docs.jpg)

***Code analysis and recommendations.*** Although there are far too many to list here, here are a few examples:

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-suggestion-1.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-suggestion-1.jpg)

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-suggestion-2.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-suggestion-2.jpg)

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-suggestion-3.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-suggestion-3.jpg)

***Type and parameter hints*** (notice the `fileName:` and `:string` hints placed here by ReSharper):

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-hints.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-hints.jpg)

#### Navigation & decompilation

***Go to definition:*** In general, you can ctrl+click most things to go to their definitions: variable names, type names, method names, etc. You can also hit F12 or right-click and choose "Go to definition".

"Go to type declaration" and "Go to type definition" are similar options I encourage you to play around with.

Very usefully, this also works on types that are outside of your project! Here's an example of seeing a decompiled source file for an external type definition. In the quick documentation, `ILogger` can be clicked on to be taken to its documentation:

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-decompile-1.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-decompile-1.jpg)

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-decompile-2.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-decompile-2.jpg)

***Find usages:*** similar to above, you can right-click most things (variables, method names, type names, etc.) and select "Go to references" to find all the usages in your project of whatever you're selecting.

Here's what that looks like when running it on a method:

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-find-usages.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-find-usages.jpg)

#### Refactoring

***Rename symbol:*** You can either hit F2 while your cursor is on a symbol or right-click on it and choose "Rename symbol" to rename all instances of that symbol.

You can also hit ctrl+F2 or "Change All Occurrences" to change all symbols with that name, whether or not they're actually the same symbol. For instance, if you had multiple methods with an argument called "sessionId", this option would change all of their names.

Here's an example showing the input that appears when renaming a symbol. Once you hit enter from here, all the symbols will update:

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-rename-symbol.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-rename-symbol.jpg)

***Extract method:*** you can highlight a section of code, click the light bulb that appears, then choose "Extract method". You can extract it to either a method or a local function.

Here's an example of extracting a code block to a method:

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-extract-method.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-extract-method.jpg)

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-extract-method-2.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-extract-method-2.jpg)

***Introduce variable:*** if you highlight an expression and choose "Introduce variable" from the light bulb that appears, it will extract the expression into a variable.

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-introduce-variable.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-introduce-variable.jpg)

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-introduce-variable-2.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-introduce-variable-2.jpg)

#### Testing

ReSharper also provides a nice test explorer interface to run and debug tests from:

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-test-explorer.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-test-explorer.jpg)

The test runner works for xUnit, NUnit, and MSTest.

You can run tests from the gutter (the pane to the left of the line numbers in the code editor) or from the test explorer. You can also navigate to the source from a failed test.

Running tests also gives you information about the test results. Here's both a passing and a failing example:

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-test-results.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-test-results.jpg)

[![](https://daninacan.com/wp-content/uploads/2026/03/kiro-test-fail.jpg)](https://daninacan.com/wp-content/uploads/2026/03/kiro-test-fail.jpg)

### Debugging

At the time of this writing, this is noted on the extension page as "coming soon." I think this is a pretty big one to have, so I'm looking forward to it!

### Closing thoughts

Overall, I'm quite happy that this offering exists in these other tools now. It makes them that much easier to work with when I'm not in my main IDE.

If you're used to Rider or the ReSharper in Visual Studio, this version of ReSharper won't have 100% of the features those have (yet, I assume). However, that doesn't mean it's not useful, and you should decide for yourself if it's fully-featured enough for your needs!
