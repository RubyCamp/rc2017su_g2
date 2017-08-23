# See: https://github.com/chipmunk-rb/chipmunk/wiki

require 'dxruby'
require 'chipmunk'

require_relative 'lib/base/cp_base'
require_relative 'lib/base/cp_box'
require_relative 'lib/base/cp_circle'
require_relative 'lib/base/cp_static_box'

require_relative 'lib/wall'
require_relative 'lib/ball'
require_relative 'lib/box'

require_relative 'scene'
require_relative 'scenes/opening/director'
require_relative 'scenes/next/director'
require_relative 'scenes/game/director'
require_relative 'scenes/pause/director'
require_relative 'scenes/ending/director'
require_relative 'scenes/result/director'

Window.width = 1024
Window.height = 768

Scene.add_scene(Opening::Director.new,  :opening)
Scene.add_scene(Next::Director.new,  :next)
Scene.add_scene(Game::Director.new,  :game)
Scene.add_scene(Pause::Director.new,  :pause)
Scene.add_scene(Ending::Director.new,  :ending)
Scene.add_scene(Result::Director.new,  :result)

Scene.set_current_scene(:opening)

Window.loop do
  break if Input.key_push?(K_ESCAPE)
  Scene.play_scene
end
