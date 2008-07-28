require("rubygems")
# require("GD")
require("sauce")
require("statemachine")

class Ansi
  S_TXT       = 0;
  S_CHK_B     = 1;
  S_WAIT_LTR  = 2;
  S_END       = 3;
  TABSTOP     = 8;
  
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
  # TODO: Allow support for passing in the ansi as a string instead of requiring a file
  def initialize(filename)
    @width=320
    @height=160

    @sauce = Sauce.new(filename)

    # file = File.new(filename, "r").read()
    file = File.new(filename, "r")
    parse(file)
    file.close
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
             # store character for writing
         end
         
       when S_CHK_B:
         #puts "S_CHK_B"
         if (ch.chr != "[")
           # store chr(27)
           # store ch
           # puts "not a bracket"
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
  
  def set_attributes(args)
    puts "set_attributes"
  end
  
  def set_position(args)
    puts "set_position"
  end
  
  def move_up(args)
    puts "move_up"
  end
  
  def move_down(args)
    puts "move_down"
  end
  
  def move_right(args)
    puts "move_right"
  end
  
  def move_left(args)
    puts "move_left"
  end
  
  def save_position(args)
    puts "save_position"
  end
  
  def restore_position(args)
    puts "restore_position"
  end
  
  def clear_screen(args)
    puts "clear_screen"
  end
  def clear_line(args)
    puts "clear_line"
  end
  
  def new_line
    puts "new_line"
  end
end
