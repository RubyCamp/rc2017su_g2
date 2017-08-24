class Basket < CPBox
  DISTANCE = 50

  def initialize(x, y, w, h, opt = {})
    super
    @hh = h
    @flug = 0
  end

  def draw
    super
    if (@body.p.y + @hh / 2 < 600) && @flug == 0
      @body.v = CP::Vec2.new(0, 20)
    else
      @body.v = CP::Vec2.new(0, 0)
      @flug = 1;
    end

    if (@body.p.y + @hh / 2 > 400) && @flug == 1
      @body.v = CP::Vec2.new(0, -20)
    else
      @flug = 0;
    end
  end
end
