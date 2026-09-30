# Reveal.js presentations

`reveal.js/` is a submodule pointing to the upstream Reveal.js repository.
The presentation files are kept outside the submodule so they are tracked by
this repository.

With Node.js 22.12.0 or newer, initialize the submodule and install its
dependencies after cloning this repository:

```sh
git submodule update --init
cd speaking-content/presentations/revealjs/reveal.js
npm ci
cd ..
npm --prefix reveal.js exec -- vite . --port 8000
```

Open http://localhost:8000/. The `index.html` file is a starter presentation.
Additional presentations can be added as separate HTML files beside it.