class Rotation < BeltsSupport::Component
  include Quat::Behaviour

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
