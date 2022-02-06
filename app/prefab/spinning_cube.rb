class SpinningCube < Prefab
  renderer :cube, color: Vec3.right
  component :spinner, Spinner.new
  # renderer :square, color: :red
  # renderer :sprite
  # renderer :cube, color: :red
  # renderer :cube, sprites: [:sprite1, :sprite2, :sprite3]
  # renderer :sphere, material: :belts_metal
  # renderer :obj, name: :monkey
end
