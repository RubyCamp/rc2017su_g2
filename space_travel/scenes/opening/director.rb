module Opening
  class Director
    def initialize
      @image = Image.load('images/start.png')
    end

    def play
      Scene.set_current_scene(:next) if Input.key_push?(K_SPACE)
      Window.draw(0, 0, @image)
    end
  end
end