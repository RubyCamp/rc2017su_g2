=begin
Window.width = 800
Window.height= 600

img=Image.load('images/dokan.png')

x=100
Window.loop do
Window.draw(x,500,img)
x=x+2
end
=end
class  Dokan <  CPStaticBox
  def initialize(x, y, w, h, opt = {})
    super
    @speed = 2
    @move_flg = true

    @deg = 0
    @image = Image.load('images/dokan.png')
  end
  
  attr_accessor :x,:y 
  
  def move
    if @move_flg == true
      @x += 2
    else
      @x -= 2
    end
  end

  def check(window_width, wall_width)

    if @move_flg == true && window_width - wall_width <= @x + 64
      @move_flg = false
    elsif @move_flg == false && wall_width >= @x
      @move_flg = true
    end
  end

  def drag

    if  @deg < 93
      if Input.mouse_down?(M_LBUTTON)
        @deg = @deg + 1
      end
    end

    if @deg>-93
      if Input.mouse_down?(M_RBUTTON)
        @deg = @deg - 1
      end
    end
    opt = {angle: @deg}
    puts @x,@y,opt
    Window.draw_ex(@x, @y, @image, opt)
  end
end
