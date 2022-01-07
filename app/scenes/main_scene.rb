class MainScene < Scene
  prefab Camera2d

  prefab GreenTriangle, position: Float3.left

  # (-1..1).each do |i|
  #   prefab SpinningCube, position: Float3.left * i
  # end

  # prefab :green_triangle, pos: [0, 1, 2]
  # prefab :green_triangle, pos: -> [(1..2).sample, (-5, 2).sample, 0]

  # 10.times { prefab :green_triangle, pos: -> [rand(2), rand(2), rand(2)] }
  # light :directional, pos: [0, 1, 2], color: :blue
end
