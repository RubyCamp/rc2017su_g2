# 円オブジェクト
class CPCircle < CPBase
  def initialize(x, y, r, opt = {})
    @r = r
    @speed_x = 50
    mass = opt[:mass] || 1  # 質量定義

    # 半径値から慣性モーメントを計算
    moment = CP::moment_for_circle(mass, 0, r, CP::Vec2.new(0, 0))

    # Bodyオブジェクト（性質）生成
    @body = CP::Body.new(mass, moment)
    @body.p = CP::Vec2.new(x + r, y + r)

    # Shapeオブジェクト（形状）生成
    @shape = CP::Shape::Circle.new(@body, r, CP::Vec2.new(0, 0))

    # Shapeに紐付ける画像を設定
    set_image(opt[:image])
  end

  # 描画
  def draw
    Window.draw_rot(
      @body.p.x - @r,
      @body.p.y - @r,
      @image,
      @body.a * 180.0 / Math::PI)

      Window.draw_box_fill(50, 50, 300, 70, C_WHITE)
      Window.draw_box_fill(50, 50, @speed_x, 70, [255, 0, 0])
      font = Font.new(23)
      Window.draw_font(90, 50, @speed_x.to_s, font)
      if Input.key_down?(K_SPACE)
          @body.v = CP::Vec2.new(rand(100), -@speed_x * 7)
      elsif  @speed_x < 300
        @speed_x = @speed_x + 2
      else @speed_x = 300
        @speed_x = 50 
      end

  end

  private

  # デフォルト画像の定義
  # CPBaseクラスで定義されている内容をオーバーライド。set_imageメソッドから呼ばれる
  def shape_default_image
    Image.new(@r * 2, @r * 2).circle_fill(@r, @r, @r,C_WHITE).line(0, @r, @r, @r, C_BLACK)
  end
end
