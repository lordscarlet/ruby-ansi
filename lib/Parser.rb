require("ANSI")
require("rubygems")
# require("GD")
require("Pixel")

class ANSI::Parser  
  S_TXT       = 0;
  S_CHK_B     = 1;
  S_WAIT_LTR  = 2;
  S_END       = 3;
  TABSTOP     = 8;

  def initialize (contents)
    
    @width=320
    @height=160

    @attr = 0
    @x = 0
    @y = 0

    # @sauce = Sauce.new(filename)

    parse(contents)
  end
  

  def parse(file)
    state = S_TXT
    argbuf = ""

    while ch = file.getc
      # puts ch.chr
      case state 
      when S_TXT:
        # puts "S_TXT"
        case ch.chr
        when 0x1a.chr:
          state = S_END
          # puts "END"
        when 0x1b.chr:
          state = S_CHK_B
        when ?\n.chr:
          new_line
          puts "new line"
        when ?\r.chr:
          # do nothing
        when ?\t.chr:
          # tab
        else
          store(ch)
        end

      when S_CHK_B:
        #puts "S_CHK_B"
        if (ch.chr != "[")
          store(chr(27))
          store(ch)
          state = S_TXT
        else
          state = S_WAIT_LTR
        end
      when S_WAIT_LTR:
        puts "S_WAIT_LTR"
        if ch.chr =~ /[a-zA-Z]/
          args = argbuf.split(/;/)
          case ch.chr
          when "m":
            set_attributes(args)
          when "H": # or "f"
            set_position(args)
          when "A":
            move_up(args)
          when "B":
            move_down(args)
          when "C":
            move_right(args)
          when "D":
            move_left(args)
          when "s":
            save_position(args)
          when "u":
            restore_position(args)
          when "J":
            clear_screen(args)
          when "K":
            clear_line(args)
          end
          argbuf = ""
          state = S_TXT
        else
          argbuf << ch
        end
      when S_END: 
        # puts "S_END"
        break
      else
        state = S_TXT
      end
    end

    # final = File.new(filename << ".png", "w")
    # image = GD::Image.new(@width, @height)
    # font = GD::Font.new('Large')
    # blue = image.colorAllocate(0,0,255)
    # image.string(font, 50, 50, "String", blue)
    # red = image.colorAllocate(255,0,0)
    # image.string(GD::Font::LargeFont, 50, 100, "String", red)
    # image.png final
  end

  def putpixel(x, y)
    if (:char != nil) 
      puts "char defined"
    end
  end

  def store(ch, x = nil, y = nil, attr = @attr)
    if (x != nil and y != nil)
      putpixel(x, y, ch, attr)
    else
      putpixel(@x, @y, ch, attr)
      @x += 1
    end
  end

  def putpixel(x, y, ch = nil, attr = nil)
    puts "putpixel"
    if (ch != nil)
      pixel = ANSI::Pixel.new(ch, attr)
    end
  end

  def set_attributes(args=[])
    # puts "set_attributes"
    args.each{ |arg|
      if (arg.to_i == 0)
        @attr = 7
      elsif arg.to_i == 1
        @attr = @attr | 8
      elsif arg.to_i == 5
        @attr = @attr | 128
      elsif arg.to_i >= 30 and arg.to_i <= 37
        @atr = @attr & 248
        @attr = @attr | (@attr - 30)
      elsif arg.to_i >= 40 and arg.to_i <= 47
        @attr = @attr & 143
        @attr = @attr | ((@attr - 40) << 4)
      end
    }
  end

  def set_position(args=[])
    @y = (args[0] != nil ? args[0] : 1) - 1
    @x = (args[1] != nil ? args[1] : 1) - 1    
  end

  def move_up(args=[])
    @y = @y - (args[0] != nil ? args[0] : 1)
  end

  def move_down(args=[])
    @y = @y + (args[0] != nil ? args[0] : 1)
  end

  def move_right(args)
    @x = @x + (args[0] != nil ? args[0].to_i : 1)
  end

  def move_left(args)
    @x = @x - (args[0] != nil ? args[0] : 1)
  end

  def save_position(args)
    @save_x = @x
    @save_y = @y
  end

  def restore_position(args)
    @x = @save_X
    @y = @save_y
  end

  def clear_screen(args)
    ansi.clear
  end
  def clear_line(args)
    ansi.clear_line(@y)
  end

  def new_line
    @y = @y + 1
    @x = 0
  end
end

