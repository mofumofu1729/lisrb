require 'test/unit'
require './lis.rb'

class TC_Lis < Test::Unit::TestCase
  def test_atom
    assert_equal(1, atom('01'))
    assert_equal(-3.14, atom('-3.14000'))
    assert_equal('a', atom('a'))
  end

  def test_read_from
    assert_equal(['+', 1, 3.14], read_from(['(', '+', '1', '3.14', ')']))
  end

  def test_tokenize
    assert_equal(['(', '+', '2', '(', '+', '1', '2', ')', ')'],
                 tokenize('(+ 2 (+ 1 2))'))
  end

class TC_Env < Test::Unit::TestCase
  def test_env
    env = Env.new
  end
end
