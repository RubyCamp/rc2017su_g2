require 'dxruby'
require 'chipmunk'

require_relative 'lib/cp_static_box'

Window.width = 640
Window.height = 480

space = CP::Space.new
space.gravity = CP::Vec2.new(0, 100)
speed = 1 / 60.0

y = 50

objects = []
objects << CPStaticBox.new(50, 200, 300, y, space)

Window.loop do
  objects.each do |obj|
    obj.draw
  y = y + 1 # 1フレーム毎にY座標を1ずつ加算し、Y軸方向への等速直線運動を実現する
end
end
