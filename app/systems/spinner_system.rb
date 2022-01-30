class SpinnerSystem < System
  def update
    @scene.collection(:transform, :spinner).each do |data|
      data => {transform:}
      transform.rotation.x = glfwGetTime() * 2.0
      transform.rotation.y = glfwGetTime() * 2.0
      #transform.rotation.z = glfwGetTime() * 2.0
    end
  end
end
