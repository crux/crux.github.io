---
layout: post
title: Google Web Fonts for my Jekyll Sass
excerpt_separator: <!--end-of-excerpt-->
---
I recently realized I like the `Serif/SanSerif` font settings on [Medium posts] more then the default styles of [my own Jekyll blog].

```sass
// google web fonts
$Serif: 'Roboto Slab', serif;
$SansSerif: 'Roboto', sans-serif;
$Monospace: 'Roboto Mono', monospace;
```
<!--end-of-excerpt-->
[This blog] is served from github and the jekyll setup forked from [Jekyll Now]. Changing the fonts is actually quite simple. Thanks to Sass and the fully automated build process on github pages you only need to change some base files:

 - \_layout/default.html
 - \_sass/\_variables.scss
 - style.scss
 - \_sass/\_highlights.scss

## Font Selection

Head over to [Google Fonts] and choose the fonts you like. I went with the Roboto family, but thats totally up to your taste. I selected the three variants serif, sanserif and monospace. Google  builds a text snippted to be included in your html header to serve your font selection from their CDN. The easiest way is to just insert that to the html header in `_layouts/default.html`:

```html
<head>
    ...
    <link href="https://fonts.googleapis.com/css?family=Roboto+Mono|Roboto+Slab:300|Roboto:500" rel="stylesheet">
</head>
```

## CSS Variables

[Sass] holds its style in the `_sass/_variables.scss` file. Transforming the native CSS (which google also gives you) into a sass variable is straightforward:

```css
font-family: 'Roboto Slab', serif;
font-family: 'Roboto', sans-serif;
font-family: 'Roboto Mono', monospace;
```

becomes: 

```sass
// google web fonts
$Serif: 'Roboto Slab', serif;
$SansSerif: 'Roboto', sans-serif;
$Monospace: 'Roboto Mono', monospace;
```

### Font Style Variable names

I don't understand the original logic in the `style.css` file of [Jekyll Now]. For example, the `h1` headlines font is set to `font-family: $helveticaNeue;`. You have a sass variable for the font family, but it is named after the content of the variable. So when now changing the font-family you would either need to put another font value into the `$helveticaNeue` variable, which is confusing, or you need to change all references to `$helveticaNeue` var to references to a new font variable. Also not a smart move. 

This is why I named the font-family var name to be the  _category_ for which they are used. Now I can rewrite the `style.scss` [sass] file and replace the headlines with the sans-serif and text with the serif variables. Easy to understand:

```scss
// use whatever Serif font i put in variables
font-family: $SanSerif; // $helveticaNeue;  
font-family: $Serif;    // $helvetica;  
```

## Missing Monospace Code Fonts

Last thing was to replace the hardcoded monospace font with a sass variable. Again with the same naming concept.

```scss
code {
  font-family: $Monospace;
  font-size: 0.8em;
}
```

## Conclusion

Jekyll and Google Fonts: easy. Blogging might even get fun again and this of course was just a test article i needed to check it out. 

[Google Fonts]: https://fonts.google.com/?category=Monospace&subset=latin-ext&selection.family=Roboto+Mono|Roboto+Slab:300|Roboto:500
[Medium Posts]: https://medium.com/coconut-stories/using-ffmpeg-with-docker-94523547f35c
[Jekyll Now]: http://github.com/barryclark/jekyll-now
[Sass]: http://sass-lang.com/
[This blog]: http://sebrink.de/
[my own Jekyll blog]: https://github.com/crux/crux.github.com
