#!/bin/sh
# Install JS dependencies and link `mdview` into ~/.local/bin.
set -e
here=$(cd "$(dirname "$0")" && pwd)
cd "$here"
npm install
mkdir -p "$HOME/.local/bin"
ln -sf "$here/mdview" "$HOME/.local/bin/mdview"
chmod +x "$here/mdview"
echo "installed: $HOME/.local/bin/mdview -> $here/mdview"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) echo "note: add \$HOME/.local/bin to your PATH";; esac
