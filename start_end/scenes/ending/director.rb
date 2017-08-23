module Ending
  class Director
    def initialize
      @image = Image.load('images/end.png')
    end

    def play
      Scene.set_current_scene(:result) if Input.key_push?(K_SPACE)
      Window.draw(0, 0, @image)
    end
  end
end