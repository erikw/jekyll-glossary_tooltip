# frozen_string_literal: true

require "simplecov" # Must be before any application code. See conf at .simplecov

require "jekyll"

Jekyll.logger.log_level = :warn

# Base directory for fixtures.
SOURCE_DIR = File.expand_path("fixtures", __dir__)
# Base directory for generated files from tests.
DEST_DIR   = File.expand_path("dest", __dir__)

# Tag matching regex parts.
R1 = %r{<span class="jekyll-glossary">\s*}
R2 = %r{\s*<span class="jekyll-glossary-tooltip">\s*}
R3 = %r{\s*<br(\s/)?><a class="jekyll-glossary-source-link" href="}
R4 = %r{" target="_blank"></a>\s*}
R5 = %r{</span>\s*</span>}

# Reference for RSpec config: https://www.rubydoc.info/github/rspec/rspec-core/RSpec/Core/Configuration
# Reference on Jekyll helper functions:
#   - https://github.com/jekyll/jekyll-seo-tag/blob/master/spec/spec_helper.rb
#   - https://github.com/ayastreb/jekyll-maps/blob/master/spec/spec_helper.rb
RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.order = :defined
  config.disable_monkey_patching!
  # Use rspec framework and the 'expect' syntax (instead of 'should')
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Get absolute path to a file within a fixture in the source dir.
  def source_dir(fixture, *filesegments)
    File.join(SOURCE_DIR, fixture, *filesegments)
  end

  # Get absolute path to file within destination output dir.
  def dest_dir(*filesegments)
    File.join(DEST_DIR, *filesegments)
  end

  def config_defaults
    {
      "destination" => dest_dir,
      "gems" => ["jekyll-glossary_tooltip"] # Called "plugins" in Jekyll >=3.5.0
    }.freeze
  end

  # Create a Jekyll site from fixtures
  def make_site(options = {})
    site_config = Jekyll.configuration(config_defaults.merge(options))
    Jekyll::Site.new(site_config)
  end

  # Ensure that there was no site before each example group (=context).
  # Remove dest dir. For using in "after :all" blocks
  def remove_dest_dir
    FileUtils.rm_rf(dest_dir)
  end

  # Expect HTML tag components to match given content.
  def expect_tag_match(content, term_name, url: true, term_display: nil, href: nil)
    term_display ||= term_name

    regex = %r{#{R1}#{term_display}#{R2}#{term_name} definition}
    if url
      href ||= "#{term_name} url"
      regex = Regexp.new(regex.source + %r{#{R3}#{href}#{R4}}.source)
    end
    regex = Regexp.new(regex.source + %r{#{R5}}.source)

    expect(content).to match(regex)
  end
end
