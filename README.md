# Jekyll Glossary Tooltip Tag Plugin [![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Get%20a%20nifty%20tooltip%20for%20term%20definitions%20in%20your%20Jekyll%20blog%20with%20this%20plugin&url=https://github.com/erikw/jekyll-glossary_tooltip&via=erik_westrup&hashtags=jekyll,plugin)
[![Gem Version](https://badge.fury.io/rb/jekyll-glossary_tooltip.svg)](https://badge.fury.io/rb/jekyll-glossary_tooltip)
[![Gem Downloads](https://ruby-gem-downloads-badge.herokuapp.com/jekyll-glossary_tooltip?color=brightgreen&type=total&label=gem%20downloads)](https://rubygems.org/gems/jekyll-glossary_tooltip)
[![Travis Build Status](https://img.shields.io/travis/erikw/jekyll-glossary_tooltip/main?logo=travis)](https://app.travis-ci.com/github/erikw/jekyll-glossary_tooltip)
[![Code Climate Maintainability](https://api.codeclimate.com/v1/badges/7ffb648ec4b77f3f9eb8/maintainability)](https://codeclimate.com/github/erikw/jekyll-glossary_tooltip/maintainability)
[![Code Climate Test Coverage](https://api.codeclimate.com/v1/badges/7ffb648ec4b77f3f9eb8/test_coverage)](https://codeclimate.com/github/erikw/jekyll-glossary_tooltip/test_coverage)
[![CodeQL](https://github.com/erikw/jekyll-glossary_tooltip/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/erikw/jekyll-glossary_tooltip/actions/workflows/codeql-analysis.yml)
[![SLOC](https://img.shields.io/tokei/lines/github/erikw/jekyll-glossary_tooltip?logo=codefactor&logoColor=lightgrey)](#)
[![License](https://img.shields.io/github/license/erikw/jekyll-glossary_tooltip)](LICENSE.txt)
[![OSS Lifecycle](https://img.shields.io/osslifecycle/erikw/jekyll-glossary_tooltip)](https://github.com/Netflix/osstracker)


:point_right: **Live demo**: https://erikw.github.io/jekyll-glossary_tooltip/

<img src="/img/tooltip_screenshot.png" width="256" align="right" alt="Screenshot of the glossary tooltip term definition" title="Example of tooltip definition of the term 'Jekyll'.">

This plugin simplifies for your readers and you by making it easy to define terms or abbreviations that needs an explanation. Define a common dictionary of terms and their definition in a YAML file. Then inside markdown files you can use the provided glossary liquid tag to insert a tooltip for a defined word from the dictionary. The tooltip will show the term definition on mouse hover.

It's also possible to provide an optional URL to for example a term definition source reference. To also support mobile devices, this URL link is placed inside the tooltip pop-up itself, rather than making the term itself clickable. This is so that on mobile device, you will first tap the word to get the hover tooltip, then click the link in the tooltip if desired.


# Installation
1. Add this gem to your Jekyll site's Gemfile in the `:jekyll_plugins` group:
   * On CLI (in project root directory):
   ```shell
   bundle add --group jekyll_plugins jekyll-glossary_tooltip
   ```
   * Or manually:
   ```ruby
   group :jekyll_plugins do
     [...]
     gem 'jekyll-glossary_tooltip'
   end
   ```
1. Run `$ bundle install`.
1. In your site's `_config.yml`, enable the plugin:
   ```yml
   plugins:
     - jekyll-glossary_tooltip
   ```
1. Create a `_data/glossary.yml` file, according to the 'Glossary Term Definition File' section below, with your terms.
1. Use the liquid tag in a page like `{% glossary term_name %}`
1. Add CSS styling for the tooltip from [jekyll-glossary_tooltip.css](lib/jekyll-glossary_tooltip/jekyll-glossary_tooltip.css). You need to make sure that the pages where you will use the glossary tag have this styling applied. Typically this would mean 1) copying this file to your `assets/css/` directory 2) editing your theme's template for blog posts (or what pages you desire) to include this CSS in the header like `<link rel="stylesheet" href="/assets/css/jekyll-glossary_tooltip.css">`. However you could also copy this file's content in to your `main.css` or `main.scss` or however you build your site's CSS.
1. Now just build your site and you will get nice nice term definition tooltips on mouse hover (or mobile, tap) for you terms!
   ```shell
   bundle exec jekyll build
   ```

# Usage
## Glossary Term Definition File
Create a file `_data/glossary.yml` to host your shared term definition entries. This file should contain a list of term entries in the format of:

```markdown
- term: a_term_name           # Can contain spaces
  definition: A description of the term
  url: https://jekyllrb.com/  # Is optional
- term: another term
  definition: Some other term definition text
```

This could look something like:
```markdown
- term: Jekyll
  definition: A Static Site Generator (SSG) built with ruby. Widely adopted as of GitHub Pages inclusion.
  url: https://jekyllrb.com/
- term: SSG
  definition: A Static Site Generator compiles the website before deployment. Then the generated web content is simply retrieved as-is by the client without any code running at retrieve time.
- term: Jamstack
  definition: JavaScript + API + Markup - a way of buildin and hosting websites.
  url: https://jamstack.org/
- term: EmbeddedLiquidURL
  definition: This definition has an URL with embedded liquid tags to make it dynamic at build time. Note special YAML syntax for being able to use liquid (1.)
  url: >
    {{ site.baseurl }}{% link page2.md %}
```

1. See [here](https://documentation.platformos.com/use-cases/using-liquid-markup-yaml) for notes on using Liquid in YAML.


## Tag Usage
On any page where you've made sure include the needed CSS styling, you can use the glossary tag simply like

```markdown
Here I'm talking about {% glossary term_name %} in a blog post.

The term name can contain spaces like {% glossary operating system %}.

Even if the term is defined in _data/glossary.yml as 'term_name', the matching is case-insensitive meaning that I can look it up using {% glossary TeRM_NaME %}. Note that the term is displayed as defined in the tag rather than the definition, here meaing 'TeRM_NaME'.

The case-styling above works as there's still a case-insensitive match. But what about when you actually want to dispaly the term differently? Maybe the term is defined as "cat" but you want to use the plural "cats"? Then you can supply an optional `display` argument. The syntax is:
{% glossary <term>, display: <diplay name> %}

This could be e.g.
{% glossary cat, display: cats %}
{% glossary some term, display: some other display text %}
```

**Note** that a term name can not contain a `,`, as this is the argument separator character.


## CSS Style Override
Simply modify the rules [jekyll-glossary_tooltip.css](lib/jekyll-glossary_tooltip/jekyll-glossary_tooltip.css) that you copied to your project. The tooltip is based on this [tutorial](https://www.w3schools.com/css/css_tooltip.asp). View the generated HTML output to see the HTML tags that are styled, or check the [tag.rb](lib/jekyll-glossary_tooltip/tag.rb) implementation in the method `render()`.


# Development
The structure of this plugin was inspired by [https://ayastreb.me/writing-a-jekyll-plugin/](https://ayastreb.me/writing-a-jekyll-plugin/), the plugin jekyll-sitemap and the [Bundler Gem tutorial](https://bundler.io/guides/creating_gem.html).

After checking out the repo;
1. Install [RVM](https://rvm.io/rvm/install) and install a supported ruby version (see .gemspec)
1. run `script/setup` to install dependencies
1. run `script/test` to run the tests
1.  You can also run `script/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.


## Local development
Following the setup at [how-to-specify-local-ruby-gems-in-your-gemfile](https://rossta.net/blog/how-to-specify-local-ruby-gems-in-your-gemfile.html), these are the steps needed to build a jekyll site with a local clone of this plugin for local testing.

1. Clone this repo to your machine, say at `~/src/jekyll-glossary_tooltip`
1. In your Jekyll project's `Gemfile`:
   - Remove the `gem 'jekyll-glossary_tooltip'` part
   - Add instead `gem 'jekyll-glossary_tooltip', github: 'erikw/jekyll-glossary_tooltip', branch: 'main'`
1. Configure bundler to use a local path for this gem in this project:
   - `$ bundle config --local local.jekyll-glossary_tooltip ~/src/jekyll-glossary_tooltip`
1. Update the project: `$ bundle install`
1. Now the project will build with the local clone of this plugin when issuing e.g. `bundle exec jekyll build`
1. When you're done:
  - Remove the local override with: `$ bundle config --delete local.jekyll-glossary_tooltip`
  - Optionally restore the original gem include in `Gemfile` or keep building from a branch in the github repo.

## Releasing
Instructions for releasing on rubygems.org below. Optionally make a GitHub [release](https://github.com/erikw/jekyll-glossary_tooltip/releases) after this for the pushed git tag.

## Using bundler/gem_tasks rake tasks
Following instructions from [bundler.io](https://bundler.io/guides/creating_gem.html#releasing-the-gem):
```shell
vi -p lib/jekyll-glossary_tooltip/version.rb CHANGELOG.md
bundle exec rake build
ver=$(ruby -r ./lib/jekyll-glossary_tooltip/version.rb -e 'puts Jekyll::GlossaryTooltip::VERSION')

# Optional: test locally by including in another project
gem install pkg/jekyll-glossary_tooltip-$ver.gem

bundle exec rake release
```

## Using gem-release gem extension
Using [gem-release](https://github.com/svenfuchs/gem-release):
```shell
vi CHANGELOG.md && git add CHANGELOG.md && git commit -m "Update CHANGELOG.md" && git push
gem bump --version minor --tag --push --release --sign
```
For `--version`, use `major|minor|patch` as needed.

## Multi-versions
* For ruby, just use RVM to switch between supported ruby version specified in `.gemspec`.
* To run with different jekyll versions, [Appraisal](https://github.com/thoughtbot/appraisal) is used with [`Appraisals`](Appraisals) to generate different [`gemfiles/`](gemfiles/)
   - To use a specific Gemfile, run like
      ```shell
      BUNDLE_GEMFILE=gemfiles/jekyll_4.x.x.gemfile bundle exec rake spec
      bundle exec appraisal jekyll-4.x.x rake spec
      ```
   - To run `rake spec` for all gemfiles:
      ```shell
      bundle exec appraisal rake spec
      ```
   - To generate new/updated gemfiles from `Appraisals`
      ```shell
      bundle exec appraisal install
      bundle exec appraisal generate --travis
      ```

## Travis
To use the [travis cli client](https://github.com/travis-ci/travis.rb) (installed from `Gemfile`):
1. Get a GitHub OAuth token by
   - going to [github.com/settings/tokens](https://github.com/settings/tokens)
   - create a new token named `travis-cli`
   - Set the scopes `repo`, `read:org`, `user:email` according to the [docs](https://docs.travis-ci.com/user/github-oauth-scopes).
1. Set travis.com as the default so we don't need to add `--pro` to most commands
   ```shell
   bundle exec travis endpoint --set-default --api-endpoint https://api.travis-ci.com/
   ```
1. Login with the cli client
   ```shell
   bundle exec travis login --github-token $GITHUB_TOKEN
   ```
1. Now the cli client can be used (might need `--pro` to use travis.com)
   ```shell
   bundle exec travis lint
   bundle exec travis accounts
   bundle exec travis status
   bundle exec travis branches
   bundle exec travis monitor
   ```

## Live Demo GitHub Pages
The live demo source is in the branch [`gh-pages-source`](https://github.com/erikw/jekyll-glossary_tooltip/tree/gh-pages-source). Check its `README.md`!

# Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/erikw/jekyll-glossary_tooltip.

# License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# Acknowledgement
Thanks to [ayastreb/jekyll-maps](https://github.com/ayastreb/jekyll-maps) for inspiration on project structure and options parsing!

# More Jekyll
Check out my other Jekyll repositories [here](https://github.com/erikw?tab=repositories&q=jekyll-&type=&language=&sort=).
