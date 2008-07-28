require("sauce")
require("Parser")

class ANSI
  attr_accessor :width, :height, :filename
  
  def initialize(ansi)
    @raw = ansi.read if ansi.respond_to? :read
    
    throw unless File.exists ansi
    @raw = File.read ansi
    
    self.read
  end
  
  def read
    ANSI::Parser.new(@raw)
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




