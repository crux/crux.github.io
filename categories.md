---
layout: page
permalink: /categories/
title: Categories
---
__Note:__ this whole category thing on this blog is not really working. I try
to put it in shape, but hey, this whole stuff dates back over ten years, and
besides the fact that I actually still need to find out _WHAT_ I want, I also
need to figure out _HOW_ to do it. And how to migrate age-old wordpress
metadata and stuff.

<div id="archives">
{% for category in site.categories %}
  <div class="archive-group">
    {% capture category_name %}{{ category | first }}{% endcapture %}
    <div id="#{{ category_name | slugize }}"></div>
    <p></p>
    
    <h3 class="category-head">
      <a id="{{ category_name | slugize }}"></a>{{ category_name }}
    </h3>

    {% for post in site.categories[category_name] %}
    <article class="archive-item">
      <li><a href="{{ site.baseurl }}{{ post.url }}">{{post.title}}</a></li>
    </article>
    {% endfor %}
  </div>
{% endfor %}
</div>
