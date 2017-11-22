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
So this is really **OLD!** I put a first [blog post online in 2006], and but
that time it was already a couple of years old and untouched. Coming from
computer graphics land I was intersted in playing with dynamic javascript for
full-screen, better say full window, display. Above is an embedded iframe, see
it [here full page].

I can exactly say as the machines and the site don't exist any more but I would
date this little javascript experiment of mine to 2001. Around that time I
realized Javascript was one of the most misunderstood languages and actually
fell in love with it. Which is for why i tried really really hard writing clean
code, something you basically unheard of by that time of `marquee` tags and
javascript clocks. Flash ruled, and I hated Flash.


[here full page]: /drops
[blog post online in 2006]: /dropjes

Actually, I'm quite proude of my javascript. It's not complicated, but it is
clean and the amazing part is, it is running basically untouched, 15 years
later in my browser. See some of the dynamic javascript abstraction code i
wrote for myself below:

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
