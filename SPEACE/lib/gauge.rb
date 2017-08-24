class Gauge
def initialize()
  @speed_x = 50

end

attr_accessor :speed_x

def draw

  Window.draw_box_fill(50, 50, 500, 70, C_WHITE)
  Window.draw_box_fill(50, 50, @speed_x, 70, [255, 0, 0])
  font = Font.new(23)
  Window.draw_font(90, 50, @speed_x.to_s, font)

  if  @speed_x < 500
    @speed_x = @speed_x + 2
  else @speed_x = 500
    @speed_x = 50
  end
  puts @speed_x
end
end
