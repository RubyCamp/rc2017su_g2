module Game3
  class Director
    WALL_WIDTH = 20
    BOX_SIZE = 30

    def initialize
      @space = CP::Space.new
      @space.gravity = CP::Vec2.new(0, 500)
      @speed = 1 / 60.0
      @objects = {}
      @image = Image.load('images/Ccourse.jpg')
      @count = 600
            @sec = 10
      #s = Sound.new("music/shoot.wav")
      #Window.loop do
      #  if bgm == true
         # s.play
        #  bgm == false
      #  end

      # 壁の生成と登録
      [
        [20, 0, Window.width - WALL_WIDTH, WALL_WIDTH],                         # 上壁
        #[0, Window.height - WALL_WIDTH, Window.width, WALL_WIDTH],              # 下壁
        [0, 0, WALL_WIDTH, Window.height - WALL_WIDTH],                         # 左壁
        [Window.width - WALL_WIDTH, 0, WALL_WIDTH, Window.height - WALL_WIDTH], # 右壁
      ].each do |x, y, w, h|
        add_obj(Wall.new(x, y, w, h))
      end

      [
        [100, 350, 130, 30],
        [100, 280, 30, 100],
        [200, 280, 30, 100],
        [400, 570, 180, 30],
        [400, 450, 30, 150],
        [550, 450, 30, 150],
        [800, 350, 130, 30],
        [800, 280, 30, 100],
        [900, 280, 30, 100]
      ].each do |x, y, w, h|
        add_obj(Basket.new(x, y, w, h))
      end

      [
        [200, 100, 200, 20],
        [700, 150, 200, 20],
        [500, 650, 200, 20]

      ].each do |x, y, w, h|
        add_obj(Obstacles.new(x, y, w, h))
      end



      @dokan=Dokan.new(50, 680, 64, 64, {image: 'images/dokan.png'})

        @gauge = Gauge.new()

      # ボールの生成
      #ball = Ball.new(50, 680, 15) #(x,y,半径)
#      ball.dokan = @dokan
      #add_obj(ball)

      # 各種当たり判定の定義
      _set_collisions

      @score = 0
    end

    # 当シーンにおける1フレームの処理を制御するコントローラメソッド
    def play
      # 物理演算空間の時間を@speed分進める
      @space.step(@speed)
      @count -= 1
      @sec = @count / 60

      Window.draw(0, 0, @image)



      loop_start = ()

      # 登録済みの全オブジェクトに対してdrawメソッドを呼び出し、画面に描画する
      # ※ @objectsに登録する全てのオブジェクトは、必ずdrawメソッドを実装していることを前提としている点に留意
      @objects.values.each {|obj| obj.draw }

       if Input.key_push?(K_SPACE)
        ball = Ball.new(@dokan.x,@dokan.y,15, @dokan.deg, @gauge.speed_x)
        add_obj(ball)
       end

      #Scene.set_current_scene(:pause) if Input.key_push?(K_P)
      @dokan.move
      @dokan.check(Window.width,WALL_WIDTH )
      @dokan.drag
      @gauge.draw
      font = Font.new(23)
      if @sec >= 0
        Window.draw_font(1024 - 170, 50,"time " + (@sec.to_s), font)
      else 
        Window.draw_font(1024 - 170, 50,"time up!", font)
      end
            
      if @sec == -5
        sleep(0)
        Scene.set_current_scene(:ending)
      end
    end


    private

    # 物理演算空間（並びに描画対象格納配列）にオブジェクトを登録
    def add_obj(obj)
      @objects[obj.shape] = obj
      obj.add_to(@space)

    end

    # 物理演算空間（並びに描画対象格納配列）からオブジェクトを削除
    def remove_obj(shape)
      @objects[shape].remove_from(@space)
      @objects.delete(shape)
      @score += 1
      Scene.set_current_scene(:ending) if @score == @items.size - 1
    end

    # 当たり判定を設定する
    # ※ サンプルなので1種類しか登録していないが、複数種類の衝突判定を登録することを想定してメソッドを分割している
    def _set_collisions
      _set_collision_ball_and_item
    end

    # ボールとアイテムの衝突判定追加
    # add_collision_handlerのブロック変数はそれぞれ衝突元（第1引数のcollision_typeに該当するオブジェクト（に含まれるShape）、
    # 衝突先（第2引数の対象オブジェクトのShape）、Arbiterオブジェクト（衝突内容の詳細を保持するオブジェクト）が入る。
    # 以下の点に留意。
    # * ブロック変数の頭2つは、Shapeオブジェクトが入るのであって、Wall/Box/Ballクラスのインスタンスではない
    # * Arbiterオブジェクトは、衝突した両者の接合点（衝突した個所）など、ゲーム作成に有用な情報を多数保持している。
    # ※ Arbiterの詳細などは、http://www.rubydoc.info/github/beoran/chipmunk/toplevel を参照
    def _set_collision_ball_and_item
      @space.add_collision_handler(Ball::DEFAULT_COLLISION_TYPE, Box::DEFAULT_COLLISION_TYPE) do |ball, box, arb|
        @space.add_post_step_callback(box) do |_, shape|
          remove_obj(shape)
        end
      end
    end
  end
end
