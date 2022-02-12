class Snake < Prefab
  renderer :square, color: Vec3.one

  component :snake_data, SnakeData.new
end
