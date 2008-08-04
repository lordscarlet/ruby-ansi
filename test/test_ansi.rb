require "test/unit"

require "ansi"

class TestAnsi < Test::Unit::TestCase
  def test_basic
    a = ANSI.new(:filename => File.dirname(__FILE__) + '/sph_love.ans')
    assert a
    assert a.to_s
    assert a.to_ascii
    assert a.to_png(:mode => "full")
    assert a.to_png(:mode => "thumbnail")
  end
end
