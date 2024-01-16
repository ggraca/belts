class Rotation < Quat
  def rotate!(x, y, z)
    self.set!(self * Quat.from_euler(x, y, z))
  end

  def forward
    self * Vec3.forward
  end

  def right
    self * Vec3.right
  end
end
