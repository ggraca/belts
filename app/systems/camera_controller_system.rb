class CameraControllerSystem < System
  def update
    @scene.collection(:transform, :camera_data).each do |data|
      data => {transform:}

      # transform.rotation.y += glfwGetTime() * 3
    end
  end
end
