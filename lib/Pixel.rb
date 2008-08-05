require("lib/ANSI")

class ANSI::Pixel
# Attribute byte constants
  ATTR_BLINK = 128;
  ATTR_BG    = 112;
  ATTR_FG    = 15;

  def initialize(ch, attr = nil)
    @char = ch
    
    if attr != nil
      @fg = attr & ATTR_FG
      @bg = attr & ATTR_BG >> 4
      @blink = attr & ATTR_BLINK >> 7
    else
      # I don't know if these should be set to 0 -- the perl code confuses me at this point
      @fg = 0
      @bg = 0
      @blink = 0
      
      attr = 0
      attr |= @fg
      attr |= @bg << 4
      attr |= @blink << 7
    end
    self     
  end
end
