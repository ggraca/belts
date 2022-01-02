class SpinnerSystem < System
  def update
    @scene.collection(:transform, :spinner).each do |data|
      data => {transform:}
      transform.rotation.x = glfwGetTime() * 150.0
      transform.rotation.y = glfwGetTime() * 50.0
      transform.rotation.z = glfwGetTime() * 10.0
    end
  end
end
