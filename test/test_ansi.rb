require "test/unit"
require "ansi"
require "ansi_to_png"

class TestAnsi < Test::Unit::TestCase
  def test_basic
    filename = File.dirname(__FILE__) + '/sph_love.ans'
    a = ANSI.new(filename)

    # I'm not quite sure how we should model these methods. For now I am doing them
    # as they are in Image-ANSI, but I think its possible we should rethink that
    # approach
    
    # png = ANSI_to_PNG::parse(a) # => should return a PNG object
    
    # png = ANSI_to_PNG::parse(filename) # => should return a PNG object

    assert a
    assert a.to_s
    assert a.to_ascii
    assert a.to_png(:mode => "full")
    assert a.to_png(:mode => "thumbnail")
  end
end
