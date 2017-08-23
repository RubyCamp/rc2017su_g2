module Ending
  class Director
    def initialize
      @image = Image.load('images/ending.png')
    end

    def play
      Window.draw(0, 0, @image)
    end
  end
end