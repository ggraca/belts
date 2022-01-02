class SnakeScene < Scene
  prefab Camera2d

  prefab Food, position: Float3.right
  prefab Snake, position: Float3.left
end
