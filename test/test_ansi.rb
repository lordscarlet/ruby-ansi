require "test/unit"

require "ansi"

class TestAnsi < Test::Unit::TestCase
  def test_basic
    a = ANSI.new(:filename => File.dirname(__FILE__) + '/sph_love.ans')
    assert a
  end
end
