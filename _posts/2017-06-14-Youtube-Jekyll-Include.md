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

## The Markup

In yout markdown page source the above video looks like this:
{% highlight html %}
{% raw %}
{ include youtube.html id=page.videoId %}
{% endraw %}{% endhighlight %}

The `page.videoId` in here is a variable from the [front matter] of your page. Alternatively you can inline the `videoId` directly (don't forget the quotes):
{% highlight html %}
{% raw %}
{ include youtube.html id="8FcfJadYysk" %}
{% endraw %}{% endhighlight %}

## The Include Snipped

The referenced include lies in `_includes/youtube.html` and looks like:
{% highlight html %}
{% raw %}
<div class="video-container"><iframe 
     src="https://www.youtube.com/embed/{{ include.id }}"
     frameborder="0" 
     allowfullscreen>
</iframe></div>
{% endraw %}{% endhighlight %}

In rendering the `include.id` get replaced and the final HTML code is written to your page:
```javascript
{% include youtube.html id="8FcfJadYysk" %}
```

[front matter]: https://jekyllrb.com/docs/frontmatter/

## Responsive Styles

The `video-container` class on the div around your video is used to add some [responsive css style] markup:

```css
.video-container {
    position:relative;
    padding-bottom:56.25%;
    padding-top:30px;
    height:0;
    overflow:hidden;
}

.video-container iframe, .video-container object, .video-container embed {
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:100%;
}
```

I put this in a sass file on its own at `_sass/_video.scss` and made the top-level `style.scss` include it with:
```css
@import "video";
```

[responsive css style]: https://coolestguidesontheplanet.com/videodrome/youtube/


_And you're wondering about the video? That was a long long time ago, in galaxy far away from here.._
