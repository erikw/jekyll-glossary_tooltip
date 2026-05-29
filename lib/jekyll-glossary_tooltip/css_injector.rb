# frozen_string_literal: true

module Jekyll
  module GlossaryTooltip
    # Automatically injects the plugin's bundled tooltip CSS into rendered HTML pages and
    # documents. Injection can be disabled via site configuration:
    #
    #   glossary_tooltip:
    #     include_default_style: false
    #
    module CssInjector
      CSS_FILE    = File.join(__dir__, "jekyll-glossary_tooltip.css")
      CSS_CONTENT = File.read(CSS_FILE).freeze
      STYLE_ID    = "jekyll-glossary-tooltip-style"
      STYLE_BLOCK = "<style id=\"#{STYLE_ID}\">\n#{CSS_CONTENT}</style>".freeze

      # Matches an opening <head> tag, including any attributes (e.g. <head lang="en">).
      HEAD_TAG_REGEX = /<head\b[^>]*>/i.freeze

      class << self
        def register_hooks
          Jekyll::Hooks.register(%i[pages documents], :post_render) do |doc|
            inject_style(doc)
          end
        end

        def inject_style(doc)
          return unless enabled?(doc.site)
          return unless doc.output.to_s.match?(HEAD_TAG_REGEX)
          return if doc.output.include?(STYLE_ID)

          doc.output = doc.output.sub(HEAD_TAG_REGEX) { |match| "#{match}\n#{STYLE_BLOCK}" }
        end

        private

        def enabled?(site)
          config = site.config["glossary_tooltip"] || {}
          config.fetch("include_default_style", true)
        end
      end
    end
  end
end

Jekyll::GlossaryTooltip::CssInjector.register_hooks
