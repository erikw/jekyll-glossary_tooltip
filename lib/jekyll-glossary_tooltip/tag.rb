# frozen_string_literal: true

require "jekyll"
require "jekyll-glossary_tooltip/errors"

module Jekyll
  module GlossaryTooltip
    # Custom liquid tag implementation.
    class Tag < Liquid::Tag
      def initialize(tag_name, args, tokens)
        super
        @opts = OptionsParser.parse(args)
      end

      def render(context)
        entry = lookup_entry(context.registers[:site], @opts[:term_query])
        @opts[:display] ||= @opts[:term_query]
        <<~HTML
          <span class="jekyll-glossary">
             #{@opts[:display]}
             <span class="jekyll-glossary-tooltip">#{entry["definition"]}#{render_tooltip_url(entry, context)}</span>
          </span>
        HTML
      end

      private

      LOG_TAG = "Glossary Tag:"

      def render_tooltip_url(entry, context)
        # The content of the anchor is set from the CSS class jekyll-glossary-source-link,
        # so that the plugin user can customize the text without touching ruby source.
        return "" if entry["url"].nil?

        url = Liquid::Template.parse(entry["url"]).render(context).strip
        "<br><a class=\"jekyll-glossary-source-link\" href=\"#{url}\" target=\"_blank\"></a>"
      end

      def lookup_entry(site, term_name)
        entry = read_term_entry_from_config(site, term_name)
        raise Errors::MissingTermDefinition, term_name unless entry["definition"]

        entry["url"] = nil unless entry.key?("url")
        entry
      end

      # Retrieve a term from the glossary via the site.
      def read_term_entry_from_config(site, term_name)
        raise Errors::NoGlossaryFile unless site.data["glossary"]

        entries = site.data["glossary"].select do |entry|
          entry.key?("term") and term_name.casecmp(entry["term"]).zero?
        end

        case entries.length
        when 0
          raise Errors::MissingTermEntry, term_name
        when 1
          entries[0]
        else
          raise Errors::MultipleTermEntries, term_name
        end
      end
    end
  end
end

Liquid::Template.register_tag("glossary", Jekyll::GlossaryTooltip::Tag)
