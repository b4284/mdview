---
title: Introduction (from front matter)
author: someone
---

# Introduction

The YAML block above is hidden, and its `title` became the browser tab title.

## Alerts

> [!NOTE]
> Useful information that users should know.

> [!TIP]
> A helpful suggestion.

> [!IMPORTANT]
> Essential information.

> [!WARNING]
> Urgent info that needs attention.

> [!CAUTION]
> Negative consequences of an action.

## Include

[!INCLUDE [shared note](~/includes/note.md)]

## Code snippet

A range of lines (`#L3-L9`) from a real source file:

[!code-csharp[Main](~/src/Program.cs#L3-L9)]

## Links

- Another article with an anchor: [Windows tab](tabs.md#windows)
- Root-relative: [home](~/index.md)
- A heading in this page: [back to alerts](#alerts)
- A cross-reference mdview cannot resolve: <xref:System.String> and [a link](xref:System.Int32)
- An image from the project root: ![logo](~/images/logo.svg)
