class MainScene < Scene
  instantiate RedTriangle, pos: :zero
  instantiate GreenTriangle, pos: :zero
  # instantiate :green_triangle, pos: [0, 1, 2]
  # instantiate :green_triangle, pos: -> [(1..2).sample, (-5, 2).sample, 0]

  # 10.times { instantiate :green_triangle, pos: -> [rand(2), rand(2), rand(2)] }
  # light :directional, pos: [0, 1, 2], color: :blue
end
