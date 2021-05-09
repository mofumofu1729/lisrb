#!/usr/bin/env ruby

################ Env

class Env < Hash
  attr_accessor :outer

  def initialize(params=[], args=[], outer=nil)
    self.merge!(params.zip(args).to_h)
    self.outer = outer
  end

  def find(var)
    if self.has_key?(var)
      return self
    else
      return self.outer.find(var)
    end
  end
end

def add_globals(env)
  env.merge!(
    {"+" => Proc.new { |a, b| a + b } ,
     "-" => Proc.new { |a, b| a - b } ,
     "*" => Proc.new { |a, b| a * b } ,
     "/" => Proc.new { |a, b| a / b } ,
    })
  return env
end

GLOBAL_ENV = add_globals(Env.new)

################ eval

def eval_exp(x, env=GLOBAL_ENV)
  # 環境の中で式を評価する
  if x.kind_of?(String)
    return env.find(x)[x]
  elsif not x.kind_of?(Array) return x else  # (proc exp*)
    exps = x.map do |exp|
      eval_exp(exp, env)
    end
    proc = exps.shift
    return proc.call(exps)
  end
end

################ parse, read, repl

def read(s)
  # 文字列からScheme式を読み込む
  return read_from(tokenize(s))
end

def tokenize(s)
  # 文字列をトークンのリストに変換する
  s.gsub('(', ' ( ').gsub(')', ' ) ').split
end

def read_from(tokens)
  # トークンの列から式を読み込む
  if tokens.size == 0
    raise "unexpected EOR while reading"
  end
  token = tokens.shift

  if token == '('
    l = []
    while tokens[0] != ')'
      l.push(read_from(tokens))
    end
    tokens.shift  # pop off ')'
    return l
  elsif token == '~'
    raise 'unexpected )'
  else
    return atom(token)
  end
end

def atom(s)
  if s =~ /^[+-]?[0-9]+$/  # 0が連続するケースも許容
    return s.to_i
  elsif s =~ /^[+-]?[0-9]+\.[0-9]*$/
    return s.to_f
  else
    return s
  end
end

def main
  loop do
    print 'lis.rb> '
    line = gets

    res = eval_exp(read(line))
    puts(res)
  end
end

if __FILE__ == $0
  main
end
