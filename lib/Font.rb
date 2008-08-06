
class ANSI::Font
  attr_accessor :width, :height, :characters
  
  def initialize(_chars = nil)
    clear
    chars(_chars) if _chars != nil
    return self
  end
end