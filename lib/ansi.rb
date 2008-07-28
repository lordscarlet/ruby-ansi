require("sauce")
require("Parser")

class ANSI
  attr_accessor :width, :height, :filename
  
  def initialize(ansi)
    
    if ansi.respond_to? :read
      @raw = ansi.read
      
    elsif ansi =~ /\n/
      @raw = ansi.to_s
      
    else
      throw unless File.exists ansi
      @raw = File.read ansi
    end
    
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




