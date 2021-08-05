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
      class NoTermNameInTag < StandardError
        def initialize; super("No term name argument for the glossary tag supplied") end
      end
    end
  end
end
