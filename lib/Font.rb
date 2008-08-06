
class ANSI::Font
  attr_accessor :width, :height, :characters, :char
  
  def initialize(_chars = nil)
    clear
    chars(_chars) if _chars != nil
    return self
  end
  
  def chars(_chars)
    @char = Array.new
    @chars = _chars[0]
    
    if @chars.length == 0
      @height = 0
      @width = 0
      @characters = []
    else
      @width = 8
      @height = @chars[0].to_i
      @characters = 0
      (@chars.length - 1).times { |i|
        @char[i] = @chars[i]
        }
    end
    
    return @chars
  end

  def clear
    @chars = []
  end
end