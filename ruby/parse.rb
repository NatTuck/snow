
require './ast.rb'

def read(text)
  tt = Tokenizer.new(text)
  pp = Parser.new(tt.tokens)
  pp.parse
end

class Tokenizer
  def initialize(text)
    @text = text
    @ii = 0
    @toks = nil
  end

  def tokens
    tokenize() if @toks.nil?
    @toks
  end

  def tokenize
    @toks = []
    until (tok = next_token).nil?
      @toks << tok
    end
  end

  def next_token
    tt = @text.slice(@ii, @text.size)
    return nil if tt.empty?
    
    # Whitespace
    if md = tt.match(/^\s+/)
      ws = md.to_s
      @ii += ws.size
      return next_token
    end

    # Parens and Brackets
    if md = tt.match(/^[\(\)\[\]]/)
      tok = md.to_s
      @ii += tok.size
      return tok
    end

    # Numbers
    if md = tt.match(/^\d[\d\.]*/)
      tok = md.to_s
      @ii += tok.size
      return SNum.new(tok)
    end

    # Symbols
    if md = tt.match(/^[\w\+\-\*\/][\w\+\-\*\/\!\?]*/)
      tok = md.to_s
      @ii += tok.size
      return SSym.new(tok)
    end

    raise Exception.new("Unknown code: #{tt.slice(0, 10)}")
  end
end

class Parser
  def initialize(toks)
    @toks = toks
    @ii = 0
  end

  def preparse(end_tok = nil)
    @ii = 0 if end_tok.nil?

    parts = []

    loop do
      tt = @toks[@ii]
      @ii += 1

      case
      when tt == end_tok
        return parts
      when tt.class == SNum || tt.class == SSym
        parts << tt
      when tt == "("
        parts << preparse(")")
      when tt == "["
        parts << preparse("]")
      else
        raise Exception.new("Unexpected token: #{tt}")
      end
    end

    if end_tok.nil?
      parts
    else
      raise Exception.new("Missing #{end_tok}")
    end
  end

  def parse
    tree = preparse

    parts = tree.map do |item|
      parse_item(item)
    end

    SMod.new("main", parts)
  end

  def parse_item(item)
    if item.class == Array
      parse_seq(item)
    else
      item
    end
  end

  def parse_seq(xs)
    if xs[0].class != SSym
      raise Exception.new("Can't apply #{xs[0]}")
    end

    head = xs[0].sym
    tail = xs.slice(1, xs.size)

    case
    when head == "struct"
      SStruct.new(tail[0], tail.slice(1, tail.size))
    when head == "defn"
      body = tail.slice(1, tail.size).map do |item|
        parse_item(item)
      end

      SDefn.new(tail[0], body)
    when head == "let"
      body = tail.slice(1, tail.size).map do |item|
        parse_item(item)
      end

      SLet.new(tail[0], body)
    else
      args = tail.map do |item|
        parse_item(item)
      end

      SCall.new(head, args)
    end
  end
end

