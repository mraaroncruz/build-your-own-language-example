require 'rltk/parser'

module NLPTrainer
  class Parser < RLTK::Parser
    Intent = Struct.new(:name, :examples)
    Example = Struct.new(:text, :entity)
    Entity = Struct.new(:entity, :value)

    production(:intents) do
      clause("intent") { |int| [int] }
      clause("intent intents") { |int, ints| ints << int }
    end

    production(:intent) do
      clause("INTENT IDENT NEWLINE example_list END") { |_, name, _, examples, _| Intent.new(name, examples) }
      clause("INTENT IDENT NEWLINE example_list NEWLINE") { |_, name, _, examples, _| Intent.new(name, examples) }
    end

    production(:example_list) do
      clause("example") { |e| [e] }
      clause("example NEWLINE example_list") { |e, _, list| list << e }
    end

    production(:example) do
      clause("text SEP entity") { |text, _, entity| Example.new(text, entity)}
      clause("text") { |text| Example.new(text)}
    end

    production(:entity) do
      clause("IDENT EQUALS IDENT") { |entity, _, value| Entity.new(entity, value) }
    end

    production(:text) do
      clause("IDENT") { |str| str }
      clause("IDENT text") { |str, sentence| [str, sentence].join(" ")}
    end

    finalize
  end
end

