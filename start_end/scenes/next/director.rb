module Next
  class Director
    def initialize
      @image = Image.load('images/next.png')
    end

    def play
      Scene.add_scene(Game::Director.new,  :game)
      Scene.set_current_scene(:game) if Input.key_push?(K_A)
      Window.draw(0, 0, @image)
    end
  end
end