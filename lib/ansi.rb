require("rubygems")
# require("sauce")
require("GD")

class ANSI
  attr_accessor :width, :height, :filename, :contents, :sauce

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
    require("lib/Parser")
    ANSI::Parser.new(contents)
  end

  def clear
    # clear out vars
    @width = 0
    @height = 0
    @image = []
  end

  def write
    # write to file
  end

  def to_s
    output = 0x1b.chr << "[0m"
    prevattr = ""

    (@height - 1).times { |y|
      _max_x = max_x(y)
      _max_x.times { |x|
        pixel = getpixel(x, y)
        # I am unsure of what Image-ANSI is doing here
        # my($char, $attr)
        if ($pixel != nil)
          args = Array.new
          args << 5 if pixel.blink
          fg = pixel.fg
          if fg > 7
            args << 1
            fg -= 8
          else args << 0
          end
          args << (fg + 30)
          bg = pixel.bg
          bg -= 8 if bg > 7
          args << (bg + 40)
          attr = args.join(";")
          char = pixel.char
        else
          attr = 0
          char = " "
        end

        if attr = prevattr 
          output << char
        else
          output << 0x1b.chr << "[#{attr}m#{char}"
        end

      }
      prevattr = attr
    }
    output << 0x1b.chr << "[0m"
    output
  end

  def max_x(args=[])
    y = args[0] != nil ? args[0].to_i : 0

    max = 0

    (@width - 1).times { |x|
      max = x if getpixel(x, y)
    }

    return max
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

  def to_ascii
    output = ""
    (@height - 1).times { |y|
      _max_x = max_x(y)
      _max_x.times { |x|
        pixel = getpixel(x,y)
        output << (pixel != nil ? pixel.char : " ")        
      }
      output << "\n" unless _max_x == 79
    }
    
    output
  end
  
  def to_png(options)
    options[:mode] = "thumbnail" unless options[:mode] != nil && options[:mode] == "full"
    
    options[:mode] == "full" ? to_png_full(options) : to_png_thumbnail(options)      
    
    return true
  end
    
  def to_png_thumbnail(options)
    options[:zoom] = 1 unless options[:zoom] != nil
    
    font = get_gd_font(options[:font])
    
    # INCOMPLETE
    return true
  end
  
  def to_png_full(options)
    return true
  end
  
  private 
  def get_gd_font(font=nil)
    require("lib/Font")
    #font = ANSI::Font::Eight_by_sixteen.new unless font != nil
    
    
    return true
  end
end




