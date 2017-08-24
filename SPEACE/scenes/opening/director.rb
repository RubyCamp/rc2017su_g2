module Opening
  class Director
    def initialize
      @image = Image.load('images/start.png')
      @sound = Sound.new('music/space_war.wav')
			@sound.loop_count = -1
			@start = 0
    end

    def play
      Scene.set_current_scene(:next) if Input.key_push?(K_SPACE)
      Window.draw(0, 0, @image)
      if @start == 0
	   		@sound.play
	    	@start += 1
      end
    end
  end
end
