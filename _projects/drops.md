---
layout: project
title: 'Color Drops in Javascript Land!'
author: <a href="https://github.com/crux/">dirk lüsebrink</a>
image: /images/drops-in-javascript-land/shot.png
excerpt_separator: <!--end-of-excerpt-->
---
Add Some color to your life: My first foray into dynamic javascript territory **from around 2001!**

{% include iframe.html src="/drops/" %}

<!--end-of-excerpt-->
I put a first [post online in 2006], by that time it was already untouched and
a couple of years old. I guess that counts as **really OLD!** Coming from
computer graphics land I was frustrated with C++, X11 and OpenGL and interested
in playing with dynamic javascript for full-screen, better say full window,
display. The stuff above is an embedded `IFrame`, you can link to the
_original_ [full page here].

I can't exactly say, as the machines and the site no longer exist, but I would
date my little javascript experiment to 2001. Around that time I realized
Javascript was one of the most misunderstood languages and fell in love with
it. Which is for why I tried really really hard writing clean code, something
basically unheard in javascript land, a time of `<marquee>` tags and javascript
clocks. Flash ruled, and I hated Flash.

[full page here]: /drops
[post online in 2006]: /dropjes

Actually, I'm quite proude of my javascript. It's not complicated, but it is
clean and the amazing part is, it is running untouched, 15 years
later in my browser. [Full source code] is now merged into this jekyll blog and
[can be found on github]. For a glimpse see some of my dynamic javascript
abstraction code below for example:

```js
function ObjectByName(name) {
    if (document.getElementById) {
        this.obj = document.getElementById(name);
        this.style = document.getElementById(name).style;
    } else if (document.all) {
        this.obj = document.all[name];
        this.style = document.all[name].style;
    } else if (document.layers) {
        this.obj = document.layers[name];
        this.style = document.layers[name];
    }
}

function writit( id, text) {
    if (document.getElementById) {
        x = document.getElementById(id);
        x.innerHTML = '';
        x.innerHTML = text;
    } else if (document.all) {
        x = document.all[id];
        x.innerHTML = text;
    }
}

function appendIt( id, text) {
    if (document.getElementById) {
        x = document.getElementById(id);
        var tmp = x.innerHTML + text;
        x.innerHTML = '';
        x.innerHTML = tmp;
    } else if (document.all) {
        x = document.all[id];
        x.innerHTML += text;
    }
}

function urldecode() {

    // return a result array even when its emtpy
    var data = new Array();
    do {
        var s = window.location.search;
        if( s == null || s == "") {
            break; // emtpy search 
        }
        if( s.charAt(0) != '?') {
            alert(" search with no question mark? somethings seriously wrong here");
            break;
        }
        s = s.substring(1); // strip the leading ?

        var parts = s.split("&");
        for( p in parts) { 
            var part = parts[p];
    //alert( p + '->' + part);
            var x = part.split("=");
            var name = dehex( x[0].replace( /\+/g," ") );
            var value = true;
            if( 1 < x.length && x[1]) {
                value = dehex( x[1].replace( /\+/g," ") );
            }
            data[name] = value;
        } 
    } while(false);

    // return result, can be empty but not null
    return data;
}

function urlparam( key, default_value) {
    var kv = urldecode();
    var value = (kv[key]) ? kv[key] : default_value;

    return value;
}
```

[Full source code]: https://github.com/crux/crux.github.io/tree/master/drops
[can be found on github]: https://github.com/crux/crux.github.io/tree/master/drops
