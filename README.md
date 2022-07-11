# Lightbox
An extension that uses the [GLightbox](https://biati-digital.github.io/glightbox/) javascript library to add lightbox styling and behavior to images on your web site or web page.

## Installation

To install this extension in your current directory (or into the Quarto project that you're currently working in), use the following command:

```bash
quarto install extension quarto-ext/lightbox
```

## Usage

The Lightbox extension is implemented as a filter in Quarto. Once installed, you can use the extension by:

1) Adding `lightbox` to the list of filters in your `_quarto.yml` file or your document front matter. For example:

```markdown
---
title: Simple Lightbox Example
filters:
   - lightbox
---
```

2) Adding the class `lightbox` to any images that you'd like to have the lightbox treatment. For example:

```markdown
---
title: Simple Lightbox Example
filters:
   - lightbox
---

![A Lovely Image](mv-1.jpg){.lightbox}
```

3) Alternatively, the GLightbox can automatically give images in your web page a lightbox treatment. You can enable this like:

```markdown
---
title: Simple GLightbox Example
filters:
   - glightbox
lightbox: auto
---

![A Lovely Image](mv-1.jpg)
```

## Galleries


## Image attributes

Implemented
- title
- description
- desc-position
- effect

Should implement?
- zoomable
- draggable

Do these work?
- width
- height


## Options

- effect
- desc-position
- match: auto




