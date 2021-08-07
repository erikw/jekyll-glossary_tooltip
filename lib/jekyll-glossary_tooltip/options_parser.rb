# frozen_string_literal: true

require "jekyll-glossary_tooltip/errors"

module Jekyll
  module GlossaryTooltip
    # Stripped down & modified version of
    # https://github.com/ayastreb/jekyll-maps/blob/master/lib/jekyll-maps/options_parser.rb
    class OptionsParser
      ARGS_PATTERN = %r{\s*(\w[-_\w]*):\s*(\w[^,\n\r]*)}
      ARGS_ALLOWED = %w[
        display
      ].freeze

      class << self
        def parse(raw_options)
          options = {
            term_query: nil,
            display: nil
          }
          opt_segments = raw_options.strip.split(",")
          raise Errors::OptionsNoTermNameInTag unless opt_segments.length.positive?

          options[:term_query] = opt_segments[0]
          opt_segments.shift
          parse_segments(options, opt_segments)
          options
        end

        def parse_segments(options, opt_segments)
          opt_segments.each do |opt_segment|
            raise Errors::OptionsBadTagArgumentFormat, options[:term_name] unless opt_segment =~ ARGS_PATTERN

            arg_name = Regexp.last_match(1)
            arg_value = Regexp.last_match(2)
            raise Errors::OptionsUnknownTagArgument, arg_name unless ARGS_ALLOWED.include?(arg_name)

            options[arg_name.to_sym] = arg_value
          end
        end
      end
    end
  end
end
