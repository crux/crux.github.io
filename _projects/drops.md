---
layout: project
title: 'Colored Drops in Javascript Land!'
author: <a href="https://github.com/crux/">dirk lüsebrink</a>
image: /images/drops-in-javascript-land/shot.png
excerpt_separator: <!--end-of-excerpt-->
---
Add Some color to your life. My first foray into dynamic javascript territory in 2001.

x
<div id=".if" style="height: 300px; bgcolor: green"> 
<iframe style="display: block; margin: auto; width: 70%" src="/drops/" frameborder="0" allowfullscreen></iframe>
</div>

<script>
window.onresize = function(e) { 
var i = document.querySelector("iframe"); 
i.style.hight = i.offsetWidth;
console.log(i.style.heigth)
}
//fitvids({ players: 'iframe[src*="/drops/"]' })
</script>

<!--end-of-excerpt-->
This is REALY old! I can exactly say at the as the machines and the site don't exist any more but I think I did this in the naughties, that would date it to something like 2001 or 2002. This was basically my first foray into javascript


```js
function random( low, high) {
    var now = new Date();
    var seed = now.getSeconds();
    return low + Math.floor( (high - low) * Math.random(seed));
}

function dec2hex( digit ) {
    if( 0 <= digit && digit < 16) {
        return "0123456789abcdef".charAt(digit);
    } else {
        return '?';
    }
}

function random_color() {
    return "#" 
        + dec2hex( random( 0, 16))
        + dec2hex( random( 0, 16))
        + dec2hex( random( 0, 16))
        + dec2hex( random( 0, 16))
        + dec2hex( random( 0, 16))
        + dec2hex( random( 0, 16))
        ;
}

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

function dehex(s) { 

    if( (s == null) || (s.length < 1)) {
        return null;
    }

    var re = /%([a-f0-9]{2})/gi; 
    return s.replace( re, function(str,p1,offset,s) { 
            return String.fromCharCode(eval("0x"+p1)) 
            }); 
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
