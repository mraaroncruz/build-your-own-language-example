require 'rltk/lexer'

module NLPTrainer
  class Lexer < RLTK::Lexer
    # Skip whitespace.
    rule(/ /)

    # Keywords
    rule(/intent/) { :INTENT }

    # Operators and delimiters.
    rule(/\/\//) { :SEP }
    rule(/=/)    { :EQUALS }
    rule(/\n/)   { :NEWLINE }

    # Identifier rule.
    rule(/[\w']+/) { |t| [:IDENT, t] }

    # Comment rules.
    rule(/#/)             { push_state :comment }
    rule(/\n/, :comment)  { pop_state }
    rule(/./, :comment)
  end
end
