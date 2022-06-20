LightData = Struct.new(:light_type) do
  def directional? = light_type == :directional

  def point? = light_type == :point

  def ambient? = light_type == :ambient
end
