#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git -C "$(dirname "${BASH_SOURCE[0]}")/../.." rev-parse --show-toplevel)"
cd "$repo_root"

submodule="speaking-content/presentations/revealjs/reveal.js"

if [[ ! -e "$submodule/.git" ]]; then
	git submodule update --init -- "$submodule"
fi

if [[ -n "$(git -C "$submodule" status --porcelain)" ]]; then
	printf 'Reveal.js has local changes; resolve them before updating.\n' >&2
	exit 1
fi

git submodule update --remote -- "$submodule"
git add -- "$submodule"
git diff --cached --submodule=log -- "$submodule"
printf 'Pinned Reveal.js commit: '
git -C "$submodule" rev-parse HEAD
printf 'Test the deck, then commit the updated pin in the parent repository.\n'