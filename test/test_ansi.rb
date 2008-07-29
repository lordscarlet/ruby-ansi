require "test/unit"
require "ansi"
require "ansi_to_png"

class TestAnsi < Test::Unit::TestCase
  def test_basic
    filename = File.dirname(__FILE__) + '/sph_love.ans'
    
    a = ANSI.new(filename)
    png = ANSI_to_PNG::parse(a) # => should return a PNG object
    
    png = ANSI_to_PNG::parse(filename) # => should return a PNG object
  end
end
