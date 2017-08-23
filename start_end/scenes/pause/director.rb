module Pause
  class Director
    def initialize
      @image = Image.load('images/pause.png')
    end

    def play
      Scene.set_current_scene(:game) if Input.key_push?(K_A)
      if Input.key_push?(K_B)
        Window.close
      end
      Window.draw(0, 0, @image)
    end
  end
end