require("sauce")
require("Parser")

class ANSI
  attr_accessor :width, :height, :filename, :contents
  
  def initialize(args)
    clear
    if args[:filename] != nil
      contents = File.new(args[:filename], "r")
    elsif args[:file] != nil
      contents = args[:file].read
    elsif args[:contents] != nil
      contents = args[:contents]
    else contents = nil
    end
    
    read(contents) if contents != nil
    
  end
  
  def read(contents)
    ANSI::Parser.new(contents)
  end
  
  def clear
    # clear out vars
    @width = 0
    @height = 0
    @image = []
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
  
  def putpixel(x, y, pixel)
    pixel(x, y, pixel)
  end
  
  def getpixel(x, y)
    pixel(x, y)
  end

  def pixel(x = 0, y = 0, pixel = nil)
      return if (pixel == nil and x > @width) or x < 0 or y < 0
      image = @image
      
      if pixel != nil
        image[y] = [] unless image[y] != nil
        image[y][x] = pixel
        @height = y + 1 if y + 1 > @height
        @width = x + 1 if x+ 1 > @width        
      end
      
      return image[y][x]
  end  

end




