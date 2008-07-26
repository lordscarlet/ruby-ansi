require("rubygems")
require("GD")

class Ansi
  class Command
    def initialize(action, arg, text)
      @arg = arg
      @text = text
      @action = action
    end
    
    def arg
      @arg
    end
    
    def action
      @action
    end
    
    def text
      @text
    end
    
    def perform_action
        case action
        when "m" # set attribute
        when "H" # set position
        when "f" # set position
        when "A" # move up
        when "B" # move down
        when "C" # move right
        when "D" # move left
        when "s" # save position
        when "u" # restore position
        when "J" # clear screen
        when "K" # clear line
        end
        print text
    end
  end
  
  
  def initialize(filename)
    @width=320
    @height=160

    file = File.new(filename, "r").read()
    matches = file.scan(/(?:\e\[(?:(\d+);?)*([A-Za-z])(.*?))(?=\e\[|\z)/)
    # print(matches.inspect())
    
    # print(matches[0].inspect())
    commands = Array.new
    matches.each { |match| commands << Ansi::Command.new(match[0], match[1], match[2])}
    commands.each {|command| command.perform_action}
    # final = File.new(filename << ".png", "w")
    # image = GD::Image.new(@width, @height)
    # font = GD::Font.new('Large')
    # blue = image.colorAllocate(0,0,255)
    # image.string(font, 50, 50, "String", blue)
    # red = image.colorAllocate(255,0,0)
    # image.string(GD::Font::LargeFont, 50, 100, "String", red)
    # image.png final
  end
  
  private
end