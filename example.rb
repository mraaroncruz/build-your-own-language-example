#require "./ch2/lexer"
#require "./ch2/parser"
require "./ch3/interpreter"

text = <<-STR
intent restaurant_search
show me chinese restaurants       // cuisine=chinese
tell me about chinese restaurants // cuisine=chinese
show me mexican restaurants       // cuisine=mexican
search for indonesian restaurants // cuisine=indonesian

intent greet
hello
hi
what's up
yo

STR

#lexed = NLPTrainer::Lexer.lex(text)
#
#parsed = NLPTrainer::Parser.parse(lexed)


ii = NLPTrainer::Rasa::Interpreter.new(text)

puts ii.print()
