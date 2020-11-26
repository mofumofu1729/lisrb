#!/usr/bin/env ruby

def main
  print 'lis.rb> '

  line = gets

  replaced = line.gsub('(', ' ( ').gsub(')', ' ) ')
  split = replaced.split()

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
