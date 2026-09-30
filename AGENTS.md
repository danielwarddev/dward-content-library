# About This Repository

This is a repository of:

- My technical blog posts (and presentation uploads) for my personal blog, https://daninacan.com/.
- My conference presentations at various conferences.
- Getting ideas for content creation.

If it seems like I'm trying to accomplish some larger task or goal, then after you finish answering the query, offer to run the [smartify](./.claude/skills/smartify/) skill for me based on the results.

## Reveal.js Submodule

Run `bash .claude/scripts/update-revealjs.sh` to fetch the latest upstream
Reveal.js commit and stage the updated submodule pin. The script refuses to
update a submodule with local changes and does not create a commit. Afterward,
run `npm ci` inside `speaking-content/presentations/revealjs/reveal.js`, preview
the deck using the instructions in `speaking-content/presentations/revealjs/README.md`,
and commit the pin in this repository once verified.