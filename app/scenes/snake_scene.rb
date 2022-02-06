class SnakeScene < Scene
  prefab Camera2d

  prefab Food, position: Vec3.right
  prefab Snake, position: Vec3.left
end
