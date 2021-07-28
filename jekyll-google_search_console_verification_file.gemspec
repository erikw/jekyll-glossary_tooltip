# frozen_string_literal: true

require_relative "lib/jekyll-glossary_tooltip/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-glossary_tooltip"
  spec.version       = Jekyll::GlossaryTooltip::VERSION
  spec.authors       = ["Erik Westrup"]
  spec.email         = ["erik.westrup@gmail.com"]

  spec.summary       = "Generate a Google Search Console verification file from your _config.yml e.g. google47733b3288357e4.html to the root of your Jekyll site."
  spec.summary       = "Jekyll plugin providing a glossary liquid tag that will show a tooltip of a term definition in your site"
  spec.description   = "TODO"
  spec.homepage      = "https://github.com/erikw/jekyll-glossary_tooltip/"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7", "< 4"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/erikw/jekyll-glossary_tooltip/"
  spec.metadata["changelog_uri"] = "https://github.com/erikw/jekyll-glossary_tooltip/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 3.7", "< 5.0"
end
