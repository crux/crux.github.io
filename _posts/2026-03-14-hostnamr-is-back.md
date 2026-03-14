---
layout: post
title: hostnamr is back, and it's static now
excerpt_separator: <!--end-of-excerpt-->
categories:
 - coding
 - javascript
 - history
 - web
---

[![hostnamr in 2006](/images/hostnamr-screenshot-061206.png)](https://sebrink.de/hostnamr)

Twenty years ago, almost to the day, I shipped [hostnamr](https://sebrink.de/hostnamr) —
a silly little one-page web app for generating pronounceable hostnames from Japanese
hiragana syllables and do-re-mi solfège. Back then it ran on Ruby on Rails, later
moved to Sinatra, and was hosted on RedHat's OpenShift cloud. Then life happened,
OpenShift changed, and it quietly went offline.

<!--end-of-excerpt-->

This week I brought it back. Not as a server-side app — as a static page, hosted on
GitHub Pages. The original HTML, CSS and JavaScript from 2006 are untouched and still
run just fine in a 2026 browser. Nothing short of amazing, honestly.

The only real change: I retired the Ruby backend and ported the two name generators
(Hiragana and Solmisation) to a small, self-contained JavaScript file. The rest — the
Prototype.js, the domtab tab switcher, the three-column layout — is exactly as it was.

If you want to see what a "web 2.0" single page application looked like in 2006, [here
you go](https://sebrink.de/hostnamr). And if you want to read the original launch post
from back then, [that's still here too](/please-give-a-warm-welcome-to-hostnamr/).

Oh, and one more thing though: I took out google analytics...

have fun
