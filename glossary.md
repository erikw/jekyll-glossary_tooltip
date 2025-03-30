---
title: "Glossary"
permalink: /glossary/
layout: page
---

A list of glossary items used on this site with my Jekyll plugin [jekyll-glossary_tooltip](https://github.com/erikw/jekyll-glossary_tooltip).


## Glossary Terms
{% assign sortedGlossary = site.data["glossary"] | sort: 'term' %}
<dl>
{% for item in sortedGlossary %}
  <dt><a href="{{item.url | liquify}}" target="_blank">{{item.term}}</a></dt>
  <dd>{{item.definition}}</dd>
{% endfor %}
</dl>