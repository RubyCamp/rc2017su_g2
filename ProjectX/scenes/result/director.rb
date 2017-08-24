module Result
  class Director
    def initialize
      @image = Image.load('images/result.png')
    end

    def play
      Scene.set_current_scene(:next) if Input.key_push?(K_A)
      if Input.key_push?(K_B)
        Window.close
      end
      Window.draw(0, 0, @image)
    end
  end
end