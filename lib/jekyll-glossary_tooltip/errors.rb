module Jekyll
  module GlossaryTooltip
    module Errors
      class NoGlossaryFile < StandardError; end
      class MissingTerm < StandardError; end
    end
  end
end
