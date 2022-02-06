class MainScene < Scene
  prefab Camera3d, position: Vec3.new(0, 0, -2)#, rotation: Vec3.new(0, 180, 0)

  # prefab GreenTriangle, position: Vec3.left * 2
  prefab SpinningCube, position: Vec3.right * 2
  prefab SpinningCube, position: Vec3.left * 2
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
