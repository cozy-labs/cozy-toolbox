Toolbox.css
===========

## Introduction

Toolbox.css aims to be a CSS framework for Cozy Cloud applications that are not
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

Toolbox.css comes as an experiment to have a light CSS framework for styling
some HTML pages where there is no React, like for the stack or Cozy-Move. As
the name suggests, it just gives a CSS file to include as is, with some
instructions on how to use it best. It does not have tons of components or
inspire to be generic. It is more a focused approach for my needs as a back-end
developer that is competent in CSS but definitely not an expert.


## Organisation

Toolbox.css is organized in several parts :

- CSS **variables** for the design tokens (fonts, colors, spacing scale, etc.)
- **Base**, with a CSS reset and some global CSS rules on tags
- **Utilities**, with some classes that maps to a single CSS property
- **Elements**, with some classes with several CSS properties for a single DOM node
- **Components**, with a way to style a small group of DOM nodes.

### CSS variables

I try to make a lot of stuff available via CSS variables. It makes the CSS a
bit heavier, but it can be useful for custom themes. To start, I have included
all the CSS variables that was available in Cozy-UI. And I added variables for
scales (font-size, spacing, z-index, etc.) and breakpoints.

**TODO** list colors

We have 6 CSS variables for breakpoints, they can be used in your CSS code but
often we rely only on the medium breakpoint as it is one used for mobile vs
desktop design.

| `--breakpointTeeny` | `375px` |
| `--breakpointTiny` | `480px` |
| `--breakpointSmall` | `768px` |
| `--breakpointMedium` | `1024px` |
| `--breakpointLarge` | `1200px` |
| `--breakpointExtraLarge` | `1440px` |

Spacing is used for both margin and paddings:

| `--spacing-xs` | `0.5rem` |
| `--spacing-s` | `0.75rem` |
| `--spacing-m` | `1rem` |
| `--spacing-l` | `1.5rem` |
| `--spacing-xl` | `2rem` |
| `--spacing-xxl` | `3rem` |

### Base

For the CSS reset, I am trying [the new reboot component of
Bootstrap](https://getbootstrap.com/docs/5.0/content/reboot/). I haven't use it
yet, but bootstrap has a solid reputation, and I appreciate avoiding the
`margin-top` as I have been surprized several times by margin collapse even if
I know [its rules](https://www.joshwcomeau.com/css/rules-of-margin-collapse/).

But, it would be too simple to just import it. I have tweaked it to my taste.
In particular, I have used the CSS variables defined sooner.

### Utilities

[Tachyons](http://tachyons.io/) and [Tailwind](https://tailwindcss.com/) are
nice CSS frameworks with lots of utilities. We don't aim to have the same
numbers of utilities, just the most common. Even Cozy-UI had stuff like `u-dit`
for `display: inline-table` that I consider too rare to include in toolbox.css.
Keep it light and simple!

The CSS classes for utilites are prefixed by `u-` and their name should find a
balance between being short and staying explicit. I find `u-maw-100` too hard
to decipher. And `u-display-block` would be too long. Tailwind is probably a
good source of inspiration for that.

| Property | class 1 | class 2 | class 3 | class 4 | class 5 |
| `display` | `u-block` | `u-flex` | `u-grid` | `u-contents` | |
| `flex` | `u-flex-col` | `u-flex-auto` | `u-justify-center` | `u-justify-between` | `u-items-center` |
| `overflow` | `u-overflow-auto` | `u-overflow-hidden` | | | |
| `position` | `u-absolute` | `u-relative` | | | |
| `top` & co. | `u-top-0` | `u-bottom-0` | `u-left-0` | `u-right:0` | |
| `box-shadow` | `u-box-shadow-1` | | | | |
| `cursor` | `u-cursor-pointer` | | | | |
| `text` | `u-italic` | `u-bold` | `u-uppercase` | `u-error` | `u-break-words` |

For margin and padding, we have a lot of possibilities
(`u-[mp][tlbr]?-(0|xs|s|m|l|xl|xxl)`):

* `u-m-s` will apply a small margin (`0.75rem`)
* `u-p-l` will apply a large padding (`1.5rem`)
* `u-mr-xl` will apply an extra large margin on the right (`2rem`)
* `u-pb-0` will remove the padding on the bottom (`0rem`)

*Notes:*

- there is no utility class for `display: hidden`, you can use the
  [`hidden` attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/hidden).
- I would like to limit the number of utilities class, maybe try with a limit
  of 100 and see what it gives. Most slots are used by margin and padding, but
  it is where the utility classes are the most useful in my humble opinion.

### Elements

| Category | class 1 | class 2 | class 3 | class 4 | class 5 |
| Buttons | `e-btn` | `e-btn-outline` | `e-btn-danger` | `e-link` | |
| Titles | `e-h1` | `e-h2` | `e-h3` | `e-h4` | |
| Texts | `e-body1` | `e-body2` | `e-caption` | | |
| Cards | `e-card` | `e-card-elevated` | `e-card-inversed` | `e-card-notice` | |
| Others | `e-fullbleed` | | | | |

<button class="e-btn">Foo</button>

*Notes:* it is common to have several utilities classes on the same tag, but
for elements classes, one should be enough.

**TODO:** wizard, c-avatar, o-field, c-label, c-chip, controls, divide

### Components

**TODO:**

- `c-address`
- `c-modal`

**Note:** toolbox.css does not provide JS code, it's your job to include the JS
to make the dynamic aspect of the components.


## How to use it

First, you should include the `toolbox.css` file in your HTML page. And you
should probably also include your own CSS file, as you will probably have some
CSS rules to cover things not included in `toolbox.css`. You should also load
the web-fonts for Lato.

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{.Title}}</title>
  <link rel="stylesheet" href="app.css">
  <link rel="stylesheet" href="toolbox.css">
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

If you want to use JavaScript, I suggest to prefer ID and data attributes to
avoid mixing classes for CSS and for JS purposes. But, if a class is really
convenient, you may choose to use the `js:` prefix to make it clear.
