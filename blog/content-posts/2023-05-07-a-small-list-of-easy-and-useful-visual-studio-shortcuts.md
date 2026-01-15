# A small list of easy and useful Visual Studio shortcuts

**Date:** May 7, 2023  
**Author:** Daniel Ward  
**URL:** https://daninacan.com/a-small-list-of-easy-and-useful-visual-studio-shortcuts/

---

All the things a modern IDE like Visual Studio can offer can be a little intimidating, and some people may not know about a lot of the functionality and think you need another IDE for some of these. I myself did not know about or use these shortcuts for many years.

To that end, I thought I would offer a small list of (in my opinion) super-useful, easy-to-memorize shortcuts that I myself use very commonly.

-   **CTRL + RR** – Rename refactor
-   **CTRL + left mouse button** – Go to definition (F12 is another shortcut, but I don't like to reach up to the function keys if I can help it)
-   **"prop" + TAB TAB** – The code snippet to generate a public property with a getter and setter. While this is the one I use the most, I encourage you to [find other snippets](https://learn.microsoft.com/en-us/visualstudio/ide/visual-csharp-code-snippets?view=vs-2022) you may also find use for
-   **CTRL + .** – Make this your new friend. Quick actions & refactoring menu
    -   **Remove unnecessary usings** (when cursor is on an import statement) – What it sounds like. I do this in every file
    -   **Generate constructor** (when cursor is inside a class) – Generates a constructor for you using the public members of the class. It appears as a checklist that you can choose the items from
    -   **Create and assign remaining as fields** (when cursor is inside constructor parameters) – When you have a constructor, but not members. It creates private backing fields for each value in the constructor and assigns them inside of it. It even prepends an underscore to the field names! You can also choose to create them as properties.
    -   **Extract interface** (when cursor is on the class name) – Creates an interface from the public members of the class. It prepends an I to the interface name and can put it in the same file as the class. Only shows up if you have public members
