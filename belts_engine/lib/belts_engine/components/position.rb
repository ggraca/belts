class Position < BeltsSupport::Component
  include Vec3Behaviour

  def move!(dir)
    self.set!(self + dir)
  end
end
