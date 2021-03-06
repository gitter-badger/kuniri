require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class MethodState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        if @language.conditionalHandler.get_conditional(pLine)
          conditional_capture
        else
          return
        end
      end

      def class_capture
        @language.rewind_state
      end

      def conditional_capture
        @language.flagFunctionBehaviour = StateMachine::METHOD_STATE
        @language.set_state(@language.conditionalState)
      end

      def execute(pElementFile, pLine)
        methodElement = @language.methodHandler.get_function(pLine)

        if (methodElement)
          lastIndex = pElementFile.classes.length - 1 # We want the index
          pElementFile.classes[lastIndex].add_method(methodElement)
        end

        if (@language.endBlockHandler.has_end_of_block?(pLine))
          class_capture
        end

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
