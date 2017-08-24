class Obstacles < CPBox
  DISTANCE = 50

  def initialize(x, y, w, h, opt = {})
    super
    @ww = w
    @flug = 0
  end

  def shape_default_image
    Image.new(width, height, [178, 190, 181])
  end

  def draw
    super

    if (@body.p.x + @ww / 1.99 < 1000) && @flug == 0
      @body.v = CP::Vec2.new(200, 0)
    else
      @body.v = CP::Vec2.new(0, 0)
      @flug = 1;
    end

  if (@body.p.x + @ww / 1.99 > 220) && @flug == 1
      @body.v = CP::Vec2.new(-200, 0)
    else
      @flug = 0;
    end
  end
end
