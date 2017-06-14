---
layout: post
title: 'Jekyll include snipped to embed Youtube Videos'
videoId: 8FcfJadYysk
excerpt_separator: <!--end-of-excerpt-->
---
Serving your blog from github pages is perfect for me, but as you you might know, you can't have plugins beyond the ones pre-defined by github. Using a [youtube plugin] is therefor not possible. Luckily you can easily build a HTML include snipped to simplify your video embedding markup.

{% include youtube.html id=page.videoId %}

[youtube plugin]: https://gist.github.com/joelverhagen/1805814
<!--end-of-excerpt-->

In the markdown markup source of you page the above video looks like this:

{% highlight html %}
{% raw %}
{ include youtube.html id=page.videoId %}
{% endraw %}{% endhighlight %}

The `page.videoId` in here is a variable from the [front matter] of your page. Alternatively you can inline the **videoId** directly (don't forget the quotes):

{% highlight html %}
{% raw %}
{ include youtube.html id="8FcfJadYysk" %}
{% endraw %}{% endhighlight %}

which becomes than rendered as:
```javascript
{% include youtube.html id="8FcfJadYysk" %}
```

[front matter]: https://jekyllrb.com/docs/frontmatter/

## Responsive Styles

Just adding some styles and without javascript you can kkkkkkkkk
https://coolestguidesontheplanet.com/videodrome/youtube/
