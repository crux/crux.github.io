---
layout: post
title: googlecharts gem URI::InvalidURIError fixed
date: 2008-01-12 14:03:38.000000000 +01:00
excerpt_separator: <!--end-of-excerpt-->
type: post
published: true
status: publish
categories:
- coding
- dirtyhack
- horror
- ruby
tags: []
meta:
  _publicize_job_id: '14401151874'
  original_post_id: '142'
  _wp_old_slug: '142'
author:
  login: joesixpack
  email: dirk.luesebrink@gmail.com
  display_name: dirk lüsebrink
  first_name: ''
  last_name: ''
---
[Yesterday] I was wondering who is right about the URI and as it turns out the culprit is the googlecharts gem. The RFC defines 'UNWISE' characters, the ruby URI implementation seem to correctly fail on them and the Google API defines the just the URI, not how it has to be encoded/escaped.
<!--end-of-excerpt-->

[Yesterday]: /ruby-google-charts-api-wrapper-rfc2396-and-ruby-open-uri-woes
[I posted the scary URI regex]: /ruby-google-charts-api-wrapper-rfc2396-and-ruby-open-uri-woes

[I posted the scary URI regex] from the ruby open-uri package which fails to grasp the Google Charts URIs. Debugging such thing is no fun so i went for a quick fix instead and actually could find it in <a href="http://googlecharts.rubyforge.org/">the googlecharts gem</a>. Just replace:

```ruby
jstize(@@url + query_params.join('&amp;'))
```

from ```...ruby/gems/1.8/gems/googlecharts-0.2.0/lib/gchart.rb``` with:

```ruby
unwise = []#%w({ } |  ^ [ ] `)
query_params.each do |p|
   unwise.each { |c| p.gsub!(c, "%#{c[0].to_s(16).upcase}") }
end

jstize(@@url + query_params.join('&amp;'))
```

this escapes the '|' (pipe) characters which were causing the exception, like this one:
```
/opt/local/lib/ruby/1.8/uri/common.rb:436:in `split': bad URI(is not URI?): http://chart.apis.google.com/chart?chdl=requests(cached)|requests&amp;chd=s:Fb9JJfgZ,Fb9KJfgq&amp;cht=lc&amp;chs=300x200 (URI::InvalidURIError)
```

Technorati Tags: <a class="performancingtags" href="http://technorati.com/tag/ruby" rel="tag">ruby</a>, <a class="performancingtags" href="http://technorati.com/tag/googlecharts" rel="tag">googlecharts</a>, <a class="performancingtags" href="http://technorati.com/tag/google" rel="tag">google</a>, <a class="performancingtags" href="http://technorati.com/tag/gem" rel="tag">gem</a>, <a class="performancingtags" href="http://technorati.com/tag/fix" rel="tag">fix</a>
