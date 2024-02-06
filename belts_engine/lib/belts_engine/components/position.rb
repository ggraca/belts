class Position < BeltsSupport::Component
  include Vec3::Behaviour

  def move!(dir)
    set!(self + dir)
  end
end
