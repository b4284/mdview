# mdview

A tiny local Markdown viewer with Mermaid support. A small Python server renders your files in the browser, and nothing is sent to any outside service.

- GitHub-flavoured Markdown, tables, task lists, relative images and links
- Mermaid diagrams (` ```mermaid ` fences), re-themed to match
- Live reload: the page re-renders about a second after the file changes
- 11 themes in a dropdown (GitHub light/dark variants, Sepia, Solarized, Nord); your choice is remembered
- Fast start: no file watcher and no directory walk
- Works well under WSL: the page renders in your Windows browser with native font rendering

## Install

Requires Python 3 and Node.js with npm.

```sh
git clone <this repo> mdview
cd mdview
./install.sh
```

The installer runs `npm install` and links `mdview` into `~/.local/bin`. Make sure that directory is on your `PATH`.

## Use

```sh
mdview README.md               # serve the file's directory and open it in the browser
mdview ~/notes                 # serve a directory (shows an index of .md files)
mdview ~/notes --open          # same, but open the browser
mdview file.md --no-open       # do not open the browser
mdview file.md -p 9000         # use another port (default 8642)
```

When the target is a file, the browser opens automatically. Under WSL it tries `wslview`, then `explorer.exe`, then `xdg-open`.

Try the demo, which exercises every feature:

```sh
mdview examples/example.md
```

## Customising

- **Themes:** edit the `THEMES` list in `viewer.html`. Custom palettes are the `body[data-theme="..."]` blocks in its `<style>` section.
- **Layout:** the max width and padding are on `.markdown-body` in `viewer.html`.
- Changes apply on the next page load; there is no build step.

## Security notes

- The server binds to `127.0.0.1` by default. Using `--host 0.0.0.0` exposes the served directory to your network.
- Files outside the served directory are refused, including `../` paths and symlinks that point outside it.
- Markdown is rendered with raw HTML allowed, so only open files you trust.

## Limitations

- No math (LaTeX) and no footnotes.
- No syntax highlighting inside code blocks.
- Mermaid is the only diagram language drawn.
