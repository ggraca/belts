class Position < Vec3
  def move!(dir)
    self.set!(self + dir)
  end
end
