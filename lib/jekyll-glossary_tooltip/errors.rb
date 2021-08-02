module Jekyll
  module GlossaryTooltip
    module Errors
      class MissingTermDefinition < StandardError; end
      class MissingTermEntry < StandardError; end
      class MultipleTermEntries < StandardError; end
      class NoGlossaryFile < StandardError; end
    end
  end
end
