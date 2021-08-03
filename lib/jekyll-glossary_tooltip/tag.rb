# frozen_string_literal: true

require "jekyll"
require "jekyll-glossary_tooltip/errors"

module Jekyll
  module GlossaryTooltip
    # Custom liquid tag implementation.
    class Tag < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      def render(context)
        entry = lookup_entry(context.registers[:site], @text)
        <<~HTML
          <span class="jekyll-glossary">
             #{@text}
             <span class="jekyll-glossary-tooltip">#{entry['definition']}#{render_tooltip_url(entry)}</span>
          </span>
        HTML
      end

      private

      LOG_TAG = "Glossary Tag:"

      def render_tooltip_url(entry)
        # The content of the anchor is set from the CSS class jekyll-glossary-source-link, so that the plugin user can customize the text without touching ruby source.
        entry["url"] ? "<br><a class=\"jekyll-glossary-source-link\" href=\"#{entry["url"]}\"></a>" : ""
      end

      def lookup_entry(site, term_name)
    	entry = read_term_entry_from_config(site, term_name)
        raise Errors::MissingTermDefinition, term_name unless entry['definition']
        entry["url"] = nil unless entry.key?("url")
        entry
      end

      # Retrieve a term from the glossary via the site.
      def read_term_entry_from_config(site, term_name)
        raise Errors::NoGlossaryFile unless site.data['glossary']

        entries = site.data['glossary'].select do |entry|
          entry.key?('term') and term_name.casecmp(entry['term']) == 0
        end

        if entries.length() == 0
          raise Errors::MissingTermEntry, term_name
        elsif entries.length() == 1
      	  return entries[0]
        else
          raise Errors::MultipleTermEntries, term_name
    	end
      end
    end
  end
end

Liquid::Template.register_tag('glossary', Jekyll::GlossaryTooltip::Tag)
