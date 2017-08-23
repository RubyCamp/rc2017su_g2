class Sidebar < CPStaticBox
  DEFAULT_COLLISION_TYPE = 1
  DEFAULT_E = 1.0
  DEFAULT_U = 0.0

  def initialize(x, y, w, h, opt = {})
    super
    self.shape.e = opt[:shape_e] || DEFAULT_E  # 弾性係数（0.0 - 1.0）
    self.shape.u = opt[:shape_u] || DEFAULT_U  # 摩擦係数（0.0 - 1.0）
    self.shape.collision_type = opt[:collision_type] || DEFAULT_COLLISION_TYPE  # 衝突種別
  end

  def shape_default_image
    Image.new(width, height, C_RED)
  end
  

end
