module Jekyll
  module GlossaryTooltip
    module Errors
      class NoGlossaryFile < StandardError; end
      class MissingTermEntry < StandardError; end
      class MissingTermDefinition < StandardError; end
    end
  end
end
