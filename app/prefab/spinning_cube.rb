class SpinningCube < Prefab
  renderer :cube, color: Float3.right

  component :transform, Transform.new(Float3.zero, Float3.zero, Float3.new(0.2, 0.2, 0.2))
  component :spinner, Spinner.new
  # renderer :square, color: :red
  # renderer :sprite
  # renderer :cube, color: :red
  # renderer :cube, sprites: [:sprite1, :sprite2, :sprite3]
  # renderer :sphere, material: :belts_metal
  # renderer :obj, name: :monkey
end
