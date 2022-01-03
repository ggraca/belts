CameraData = Struct.new(:projection_type) do
  def perspective? = projection_type == :perspective
  def orthographic? = projection_type == :orthographic
end
