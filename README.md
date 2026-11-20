# mdview

A tiny local Markdown viewer with Mermaid support. A small Python server renders your files in the browser, and nothing is sent to any outside service.

- GitHub-flavoured Markdown, tables, task lists, relative images and links
- Mermaid diagrams (` ```mermaid ` fences), re-themed to match
- Live reload: the page re-renders about a second after the file changes
- 11 themes in a dropdown (GitHub light/dark variants, Sepia, Solarized, Nord); your choice is remembered
- Fast start: no file watcher and no directory walk
- Understands [DocFX](https://dotnet.github.io/docfx/) articles: includes, code snippets, alerts, tabs, front matter and `toc.yml` (see below)
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
mdview ~/notes                 # serve a directory (index of .md files) and open it
mdview ~/notes --no-open       # do not open a browser
mdview file.md -p 9000         # use another port (default 8642)
mdview file.md --no-check      # skip the startup checks below
```

The browser opens by default for files and directories. Under WSL `mdview` tries `wslview`, then `explorer.exe`, then `xdg-open`.

## Errors

`mdview` exits with an error, and does not start the server, when:

- the path does not exist
- the file cannot be read, looks binary, or is not valid UTF-8
- an `[!INCLUDE]` or `[!code-*]` file it refers to is missing or outside the served folder

Missing local images and linked `.md` pages only produce a warning, since the rest of the page still renders. Problems that only show up in the browser, such as a Mermaid diagram that fails to parse or a script error, are printed to the terminal as `mdview: warning: ...`. Use `--no-check` to serve a file despite the startup errors.

Try the demo, which exercises every feature:

```sh
mdview examples/example.md
```

## DocFX support

`mdview` is a quick local preview for DocFX articles, not a replacement for `docfx build`. Try the sample project:

```sh
mdview examples/docfx/articles/intro.md
```

When you open a file inside a project, `mdview` serves from the folder holding `docfx.json`, so `~/` links and includes outside the article's own folder resolve.

| DocFX feature | What mdview does |
|---|---|
| YAML front matter | Hidden; its `title` becomes the tab title |
| Links to other `.md` files, with `#anchors` and `~/` paths | Open in the viewer; heading anchors work |
| `[!INCLUDE [t](path)]` | Expanded in place (nested, up to 5 levels), with relative images fixed up |
| `[!code-lang[t](path#L10-L20)]` | Replaced by a code block of those lines |
| `> [!NOTE]`, `TIP`, `IMPORTANT`, `WARNING`, `CAUTION` | Styled callouts |
| `#### [Title](#tab/id)` tabs | Real tabs; groups with the same id switch together |
| `toc.yml` | Sidebar navigation from the nearest `toc.yml`; nested `href: folder/` tocs load on demand; toggle with the ☰ button |
| `<xref:uid>` and `xref:` links | Shown as plain text with a dotted underline: they need DocFX's API metadata, which `mdview` doesn't have |

Not supported: code snippet tags (`?name=`, `#tag`; the whole file is shown), `[!VIDEO]`, `[!div]`, custom `docfx.json` path mappings (`src`/`dest`), and tabs inside lists or quotes.

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
