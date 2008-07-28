require("sauce")
require("Parser")

class ANSI
  attr_accessor :width, :height, :filename
  
  def initialize(filename)
    @filename = filename
    
    self.read
  end
  
  def read
    ANSI::Parser.new(@filename)
  end
  
  def sauce
    @sauce
  end

  def lines
    0
  end

  def title
    @sauce.title
  end

  def author
    @sauce.author
  end

end




