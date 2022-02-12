class CameraControllerSystem < System
  collection :cameras,
    with: [:transform, :camera_data]

  def update
    cameras.each do |data|
      data => {transform:}

      # transform.rotation.y += glfwGetTime() * 3
    end
  end
end
