# frozen_string_literal: true

require "jekyll"

# TODO raise correct object for exceptions
# TODO use safe navigation if appropriate. What happens if key/attrib don't exist?

module Jekyll
  # Custom liquid tag definition.
  class GlossaryTag < Liquid::Tag
      safe true
      priority :lowest

    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      entry = lookup_entry(context.registers[:site], @text)
      <<~HTML
        <span class="jekyll-glossary">
           #{entry['term']}
           <span class="jekyll-glossary-tooltip">#{entry['definition']}#{render_tooltip_url(entry)}</span>
        </span>
      HTML
    end

  	private

  	LOG_TAG = "Glossary Tag:"

    def render_tooltip_url(entry)
      entry.key?("url") and entry["url"] ? "<br><a class=\"jekyll-glossary-source-link\" href=\"#{entry["url"]}\">source</a>" : ""
    end

  	def lookup_entry(site, term_name)
  	  entry = read_term_entry_from_config(site, term_name)
  	  if not (entry.key?('definition') and entry['definition']) # TODO save navigation can also check of the value is non-zero?
        raise ArgumentError, "Glossary entry for #{term_name} does not contain a definition!"
      end
      if not entry.key?('url')
        entry['url'] = nil
      end
      entry
  	end

  	# Retrieve a term from the glossary via the site.
  	def read_term_entry_from_config(site, term_name)
      raise ArgumentError, "No data.glossary found" unless site.data['glossary']

      entries = site.data['glossary'].select do |entry|
        entry.key?('term') and term_name.casecmp(entry['term']) == 0
      end

      if entries.length() == 0
      	raise ArgumentError, "The term '#{term_name}' was not defined in the glossary"
      elsif entries.length() == 1
		return entries[0]
      else
      	raise ArgumentError, "The term #{term_name} was defined multiple times in the glossary"
  	  end
  	end
  end
end

Liquid::Template.register_tag('glossary', Jekyll::GlossaryTag)
