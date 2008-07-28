require("sauce")
require("Parser")

class ANSI
  attr_accessor :width, :height, :filename, :contents
  
  def initialize(args)
    if args[:filename] != nil
      contents = File.new(args[:filename], "r")
    elsif args[:file] != nil
      contents = args[:file].read
    else
      contents = args[:contents]
    end

    @contents = contents
    
    self.read
  end
  
  def read
    ANSI::Parser.new(@contents)
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




