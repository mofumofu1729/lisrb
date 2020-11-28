#!/usr/bin/env ruby
def read(s)
  # 文字列からScheme式を読み込む
  return read_from(tokenize(s))
end

def tokenize(s)
  # 文字列をトークンのリストに変換する
  s.gsub('(', ' ( ').gsub(')', ' ) ').split()
end

def read_from(tokens)
  # トークンの列から式を読み込む
  tokens  # TODO 実装
end

def main
  print 'lis.rb> '

  line = gets

  split = read(line)
  op = split[1]
  a = split[2].to_i
  b = split[3].to_i

  if op == '+'
    puts a+b
  elsif op == '-'
    puts a-b
  elsif op == '*'
    puts a*b
  elsif op == '/'
    puts a/b
  end
end

if __FILE__ == $0
  main
end
