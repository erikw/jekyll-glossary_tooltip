# frozen_string_literal: true

module Jekyll
  module GlossaryTooltip
    module Errors
      class MissingTermDefinition < StandardError
        def initialize(term_name); super("Glossary entry for '#{term_name}' does not contain a definition!") end
      end
      class MissingTermEntry < StandardError
        def initialize(term_name); super("The term '#{term_name}' was not defined in the glossary") end
      end
      class MultipleTermEntries < StandardError
        def initialize(term_name); super("The term '#{term_name}' was defined multiple times in the glossary") end
      end
      class NoGlossaryFile < StandardError; def initialize; super("No data.glossary found") end end
      class OptionsNoTermNameInTag < StandardError
        def initialize; super("No term name argument for the glossary tag supplied") end
      end
      class OptionsBadTagArgumentFormat < StandardError
        def initialize(term_name); super("The glossary tag for term '#{term_name}' has a bad argument format") end
      end
      class OptionsUnknownTagArgument < StandardError
        def initialize(arg); super("An unknown tag argument #{arg} was encountered") end
      end
    end
  end
end
