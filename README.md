# Lightbox

An extension that uses the [GLightbox](https://biati-digital.github.io/glightbox/) javascript library to add lightbox styling and behavior to images in your HTML documents.

## Installation

To install this extension in your current directory (or into the Quarto project that you're currently working in), use the following command:

``` bash
quarto add quarto-ext/lightbox
```

## Usage

The Lightbox extension is implemented as a filter in Quarto. Once installed, using the extension is easy.

### Apply To Images Automatically

The Lightbox extension can automatically give images in your web page a lightbox treatment. You can enable this like:

``` markdown
---
title: Simple Lightbox Example
filters:
   - lightbox
lightbox: auto
---

![A Lovely Image](mv-1.jpg)
```

You can exclude an image from receiving this automatic treatment by giving it a `nolightbox` class, like so:

``` markdown
![Don't lightbox me!](mv-1.jpg){.nolightbox}
```

### Choose Specific Images

1)  Add `lightbox` to the list of filters in your `_quarto.yml` file or your document front matter. For example:

``` markdown
---
title: Simple Lightbox Example
filters:
   - lightbox
---
```

2)  Add the class `lightbox` to any images that you'd like to have the lightbox treatment. For example:

``` markdown
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

``` markdown
![A Lovely Image](mv-1.jpg){group="my-gallery"}

![Another Lovely Image](mv-2.jpg){group="my-gallery"}

![The Last Lovely Image](mv-3.jpg){group="my-gallery"}
```

## Global Options

The following options may be specified in the front matter for lightbox:

| Option          | Description                                                                                                                                                              |
|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `match`         | Set this to `auto` if you'd like any image to be given lightbox treatment. If you omit this, only images with the class `lightbox` will be given the lightbox treatment. |
| `effect`        | The effect that should be used when opening and closing the lightbox. One of `fade`, `zoom`, `none`. Defaults to `zoom`.                                                 |
| `desc-position` | The position of the title and description when displaying a lightbox. One of `top`, `bottom`, `left`, `right`. Defaults to `bottom`.                                     |
| `loop`          | Whether galleries should 'loop' to first image in the gallery if the user continues past the last image of the gallery. Boolean that defaults to `true`.                 |
| `css-class`     | A class name to apply to the lightbox to allow css targeting. This will replace the lightbox class with your custom class name.                                                                                                            |

A complete example:

``` markdown
---
title: Complete Lightbox Example
filters:
  - lightbox
lightbox:
  match: auto
  effect: fade
  desc-position: right
  loop: false
  css-class: "my-css-class"
---
```

## Per Image Attributes

The following options may be specified as attributes on individual images to control the lightbox behavior:

| Option          | Description                                                                                                                         |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `desc-position` | The position of the title and description when displaying a lightbox. One of `top`, `bottom`, `left`, `right`. Defaults to `bottom` |

## Example

Here is the source code for a minimal example: [example.qmd](https://github.com/quarto-ext/lightbox/blob/main/example.qmd)

This is the output of [example.qmd](https://quarto-ext.github.io/lightbox/).




