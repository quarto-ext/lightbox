# Lightbox
An extension that uses the [GLightbox](https://biati-digital.github.io/glightbox/) javascript library to add lightbox styling and behavior to images on your web site or web page.

## Installation

To install this extension in your current directory (or into the Quarto project that you're currently working in), use the following command:

```bash
quarto install extension quarto-ext/lightbox
```

## Usage

The Lightbox extension is implemented as a filter in Quarto. Once installed, using the extension is easy.

### Apply To Images Automatically

The GLightbox can automatically give images in your web page a lightbox treatment. You can enable this like:

```markdown
---
title: Simple GLightbox Example
filters:
   - glightbox
lightbox: auto
---

![A Lovely Image](mv-1.jpg)
```

You can exlude an image from receiving this automatic treatment by giving it a `nolightbox` class, like so:

```markdown
![Don't lightbox me!](mv-1.jpg){.nolightbox}
```

### Choose Specific Images

1) Add `lightbox` to the list of filters in your `_quarto.yml` file or your document front matter. For example:

```markdown
---
title: Simple Lightbox Example
filters:
   - lightbox
---
```

2) Add the class `lightbox` to any images that you'd like to have the lightbox treatment. For example:

```markdown
---
title: Simple Lightbox Example
filters:
   - lightbox
---

![A Lovely Image](mv-1.jpg){.lightbox}
```

## Galleries

In addition to simply providing a lightbox treatment for individual images, you can also group images into a 'gallery'. When the user activates the lightbox, they will be able to page through the images in the gallery without returning to the main document. To create galleries of images, apply a `group` attribute (with a name) to the images that you'd like to gather into a gallery. Images with the same group name will be placed together in a gallery when given a lightbox treatment.

For example, the following three images will be treated as a gallery:

```markdown
![A Lovely Image](mv-1.jpg){group="my-gallery"}

![Another Lovely Image](mv-2.jpg){group="my-gallery"}

![The Last Lovely Image](mv-3.jpg){group="my-gallery"}
```

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

Should I implement these?
- skin (adds css class to lightbox for css targeting)
- loop (loop galleries)
- preload (boolean, disables or enables preloading)


