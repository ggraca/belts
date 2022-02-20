class Light < Belts::Prefab
  component :light_data, LightData.new(:directional)
end
