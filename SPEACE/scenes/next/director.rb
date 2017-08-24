module Next
  class Director
    def initialize
      @image = Image.load('images/sky2.jpg')
    end

    def play
      Scene.add_scene(Game::Director.new,  :game)
      Scene.add_scene(Game2::Director.new,  :game2)
      Scene.add_scene(Game3::Director.new,  :game3)
      Scene.set_current_scene(:game) if Input.key_push?(K_A)
      Scene.set_current_scene(:game2) if Input.key_push?(K_B)
      Scene.set_current_scene(:game3) if Input.key_push?(K_C)
      Window.draw(0, 0, @image)
    end
  end
end