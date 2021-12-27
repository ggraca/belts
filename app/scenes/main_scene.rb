class MainScene < Scene
  pp GreenTriangle.components
  instantiate GreenTriangle, pos: :zero
  pp GreenTriangle.components
  instantiate RedTriangle, pos: :zero
  pp GreenTriangle.components
  # instantiate :green_triangle, pos: [0, 1, 2]
  # instantiate :green_triangle, pos: -> [(1..2).sample, (-5, 2).sample, 0]

  # 10.times { instantiate :green_triangle, pos: -> [rand(2), rand(2), rand(2)] }
  # light :directional, pos: [0, 1, 2], color: :blue
end
