Tools.css
=========

## Introduction

Tools.css aims to be a CSS framework for Cozy Cloud applications that are not
in React.

Historically, Cozy-UI was our toolkit for UI purposes and was covering both the
React and non-React use cases. But it has always been a bit complicated to give
both React components and a CSS file that can be used without JS. Moreover, we
wanted to embrace [Material-UI](https://material-ui.com/) to improve our React
components without lot of efforts. It means that we can't continue to support
the CSS file as it is today, and it was decided that our time wouldn't be used
at its best by keep this split direction of Cozy-UI. So, using Cozy-UI in an
app via a CSS file is going to be deprecated. We still want to share the CSS
variables of the theme, but that's all.

Tools.css comes as an experiment to have a light CSS framework for styling some
HTML pages where there is no React, like for the stack or Cozy-Move. As the name
suggests, it just gives a CSS file to include as is, with some instructions on
how to use it best. It does not have tons of components or inspire to be generic.
It is more a focused approach for my needs as a back-end developer that is
competent in CSS but definitely not an expert.


## Organisation

Tools.css is organized in several parts :

- CSS **variables** for the design tokens (fonts, colors, spacing scale, etc.)
- **Base**, with a CSS reset and some global CSS rules on tags
- **Utilities**, with some classes that maps to a single CSS property
- **Elements**, with some classes with several CSS properties for a single DOM node
- **Components**, with a way to style a small group of DOM nodes
- **Layouts**, to organize the global page layout.

### CSS variables

**TODO**

### Base

For the CSS reset, I am trying [the new reboot component of
Bootstrap](https://getbootstrap.com/docs/5.0/content/reboot/). I haven't use it
yet, but bootstrap has a solid reputation, and I appreciate avoiding the
`margin-top` as I have been surprized several times by margin collapse even if
I know [its rules](https://www.joshwcomeau.com/css/rules-of-margin-collapse/).

### Utilities

[Tachyons](http://tachyons.io/) and [Tailwind](https://tailwindcss.com/) are
nice CSS frameworks with lots of utilities. We don't aim to have the same
numbers of utilities, just the most common. Even Cozy-UI had stuff like `u-dit`
for `display: inline-table` that I consider too rare to include in tools.css.
Keep it light and simple!

The CSS classes for utilites are prefixed by `u:` and their name should find a
balance between being short and staying explicit. I find `u-maw-100` too hard
to decipher. And `u:display-block` would be too long. Tailwind is probably a
good source of inspiration for that.

### Elements

- `e:title1`
- `e:btn`
- `e:elevation`
- `e:sr-only`

### Components

- `c:address`
- `c:modal`

**Note:** tools.css does not provide JS code, it's your job to include the JS
to make the dynamic aspect of the components.

### Layouts

CSS grids are our tool of choice for the layouts. The framework include a few
layouts to start, but feel free to make your owns. The CSS classes for layouts
are prefixed by `l:`.


## How to use it

First, you should include the `tools.css` file in your HTML page. And you
should probably also include your own CSS file, as you will probably have some
CSS rules to cover things not included in `tools.css`. You should also load
the web-fonts for Lato.

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{.Title}}</title>
  <link rel="stylesheet" href="app.css">
  <link rel="stylesheet" href="tools.css">
</head>

<body>
  <main role="application">
    <!-- ... -->
  </main>
  <script src="app.js"></script>
</body>

</html>
```

```css
/* app.css */
@font-face {
  font-family: Lato;
  font-style: normal;
  font-weight: normal;
  src: url("../fonts/Lato-Regular.immutable.woff2") format("woff2");
}
@font-face {
  font-family: Lato;
  font-style: normal;
  font-weight: bold;
  src: url("../fonts/Lato-Bold.immutable.woff2") format("woff2");
}

/* and your styles... */
```

The woff2 files are available on [the `assets/fonts` of
Cozy-UI](https://github.com/cozy/cozy-ui/tree/master/assets/fonts).

If you want SVG icons, you can look at [the `assets/icons` of
Cozy-UI](https://github.com/cozy/cozy-ui/tree/master/assets/icons).