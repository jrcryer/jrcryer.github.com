---
layout: posts
current: posts
title: Boilerplate Gruntfile for Github pages
description: Boilerplate Gruntfile for working with Github pages.  Includes SASS, LiveReload, JSHint and ImageMin.
excerpt: Boilerplate Gruntfile for working with Github pages.  Includes SASS, LiveReload, JSHint and ImageMin.
keyword: Developer Workflow, SASS, LiveReload, Gruntfile
---

![Grunt and Github pages build](/img/grunt-github-pages.png)

Whilst updating this site, I thought it was time to _eat my own dog food_ by optimising my  workflow for the site.

I've now setup a [Grunt Gruntfile](http://gruntjs.com/sample-gruntfile) to control building the site locally which includes:

* [SASS](http://sass-lang.com/)
* [LiveReload](http://livereload.com/)
* [JSHint](http://jshint.org)
* [RECESS](http://twitter.github.io/recess/)
* [ImageMin](https://github.com/gruntjs/grunt-contrib-imagemin)

I've published this very simple Gruntfile as a [gist](https://gist.github.com/jrcryer/8166449) for others to use.  Please feel free to use it to bootstrap your Github page development.

The Gruntfile uses a combination of grunt-jekyll, grunt-contrib-watch and grunt-contrib-connect to re-build the site and reload the page in the browser (without the need to refresh the page).