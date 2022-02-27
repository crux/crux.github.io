---
layout: page
permalink: /categories/
title: Tags & Categories
---
_(please note: my tagging sucks. I know, I am working on it. This whole jekyll
category thing is something still need to get righ, bear with me. Most content
here is ages old, from pre-migration HTML files, which are not holding any
correct category and meta information.)_

<section>
categories: 
{% for category in site.categories %}
    {% capture category_name %}{{ category | first }}{% endcapture %}
    <span id="#{{ category_name | slugize }}">
      <a 
        href="{{ site.baseurl }}/categories/#{{ category_name | slugize }}"
      >#{{ category_name }}</a>
    </span>
{% endfor %}
</section>

<section id="archives">
{% for category in site.categories %}
  <div class="archive-group">
    {% capture category_name %}{{ category | first }}{% endcapture %}
    <div id="#{{ category_name | slugize }}"></div>
    
    <h3 class="category-head">
      <a id="{{ category_name | slugize }}"></a>{{ category_name }}
    </h3>

    <ul>
    {% for post in site.categories[category_name] %}
      <!--article class="archive-item"-->
      <li><a href="{{ site.baseurl }}{{ post.url }}">{{post.title}}</a></li>
      <!--/article-->
    {% endfor %}
    </ul>
  </div>
{% endfor %}
</section>
