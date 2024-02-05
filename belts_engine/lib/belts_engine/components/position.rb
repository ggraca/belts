class Position < BeltsSupport::Component
  include Vec3::Behaviour

  def move!(dir)
    self.set!(self + dir)
  end
end
