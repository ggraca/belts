class MainScene < Scene
  prefab Camera3d, position: Vec3[0, 0, -5]

  # prefab GreenTriangle, position: Vec3.left * 2
  # prefab SpinningCube, position: (Vec3.up + Vec3.forward) * -2
  # prefab SpinningCube, position: (Vec3.right + Vec3.forward) * -2
  # prefab SpinningCube, position: Vec3.forward * -2
  prefab GreenTriangle
  prefab GreenTriangle, position: Vec3.left
  prefab GreenTriangle, position: Vec3.right
  prefab GreenTriangle, position: Vec3.up
  prefab GreenTriangle, position: Vec3.down
  prefab GreenTriangle, position: Vec3.up + Vec3.right
  prefab GreenTriangle, position: Vec3.up * 2 + Vec3.right * 2
  prefab SpinningCube, position: Vec3.right * 2
  prefab SpinningCube, position: Vec3.left * 2
  prefab SpinningCube, position: Vec3.up * 2
  prefab SpinningCube, position: Vec3.up * 2 + Vec3.left * 2
  # prefab SpinningCube, position: Vec3.left * 2
  # prefab SpinningCube, position: Vec3.right

  # (-1..1).each do |i|
  #   prefab SpinningCube, position: Vec3.left * i
  # end

  # prefab :green_triangle, pos: [0, 1, 2]
  # prefab :green_triangle, pos: -> [(1..2).sample, (-5, 2).sample, 0]

  # 10.times { prefab :green_triangle, pos: -> [rand(2), rand(2), rand(2)] }
  # light :directional, pos: [0, 1, 2], color: :blue
end
