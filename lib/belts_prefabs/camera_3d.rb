class Camera3d < Belts::Prefab
  component :camera_data, CameraData.new(:perspective)
end
