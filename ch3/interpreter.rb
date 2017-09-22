require "json"
require "./ch3/lexer"
require "./ch3/parser"

module NLPTrainer
  module Rasa
    class Interpreter
      def initialize(code)
        @code = code
      end

      def print
        tokens = Lexer.lex(@code)
        ast = Parser.parse(tokens)
        intents = interpret(ast)
        full = wrap(intents)
        output(full)
      end

      # It should look like this
      #[
      #  {
      #    "text": "show me chinese restaurants",
      #    "intent": "restaurant_search",
      #    "entities": [
      #      {
      #        "start": 8,
      #        "end": 15,
      #        "value": "chinese",
      #        "entity": "cuisine"
      #      }
      #    ]
      #  }
      #]

      def interpret(ast)
        ast.flat_map { |intent|
          intent.examples.map { |ex| parse_example(ex, intent.name) }
        }
      end

      def parse_example(ex, intent_name)
        example = {
          intent: intent_name,
          text: ex.text
        }
        if e = ex.entity
          offset = get_offset(e.value, ex.text)
          example.merge!(entities: [
            value: e.value,
            entity: e.entity,
            start: offset[0],
            end: offset[1]
          ])
        end
        example
      end

      def wrap(intents)
        {
          rasa_nlu_data: {
            common_examples: intents,
            regex_features:  [],
            entity_synonyms: []
          }
        }
      end

      def output(json)
        JSON.dump(json)
      end

      def get_offset(value, str)
        at = str.index(value)
        if at.nil?
          raise ArgumentError, "Error: Entity '#{value}' does not appear in input string '#{str}'"
        end
        [at, at + value.size]
      end
    end
  end
end
