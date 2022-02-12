class SnakeScene < Scene
  prefab Camera2d, position: Vec3[0, 0, -10]

  prefab Food, position: Vec3.right
  prefab Snake, position: Vec3.left
end
