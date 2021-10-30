# jekyll-4.x.x-test Live Demo
Deployed at https://erikw.github.io/jekyll-glossary_tooltip/

# Deployment
```console
$ bundle install
$ bundle exec jekyll serve --open-url
$ bundle exec rake deploy
```

# Notes
* Need to override template _includes/head.html to change the CSS include to be relative, as it's deployed not on the top level. Reference: https://stackoverflow.com/a/62683398/265508
