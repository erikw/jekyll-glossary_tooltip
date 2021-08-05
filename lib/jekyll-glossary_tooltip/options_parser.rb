# Stripped down & modified version of https://github.com/ayastreb/jekyll-maps/blob/master/lib/jekyll-maps/options_parser.rb
require "jekyll-glossary_tooltip/errors"

module Jekyll
  module GlossaryTooltip
    class OptionsParser
      ARGS_PATTERN = %r!\s*(\w[-_\w]*):\s*(\w[^,\n\r]*)!
      ARGS_ALLOWED = %w(
        display
      ).freeze

      class << self
        def parse(raw_options)
          options = {
            term_query: nil,
            display: nil
          }
          opt_segments = raw_options.strip.split(',')
          if opt_segments.length > 0
            options[:term_query] = opt_segments[0]
            opt_segments.shift
          else
            raise Errors::OptionsNoTermNameInTag
          end
          opt_segments.each do |opt_segment|
            if opt_segment =~ ARGS_PATTERN
              arg_name = $1
              arg_value = $2.strip
              if ARGS_ALLOWED.include?(arg_name)
                options[arg_name.to_sym] = arg_value
              else
                raise Errors::OptionsUnknownTagArgument, arg_name
              end
            else
              raise Errors::OptionsBadTagArgumentFormat, options[:term_name]
            end
          end
          options
        end
      end
    end
  end
end
