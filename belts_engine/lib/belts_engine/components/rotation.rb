class Rotation < BeltsSupport::Component
  include QuatBehaviour

  def rotate!(quat)
    quat_mul!(quat)
  end

  def forward
    self * Vec3.forward
  end

  def right
    self * Vec3.right
  end
end
