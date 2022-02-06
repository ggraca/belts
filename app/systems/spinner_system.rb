class SpinnerSystem < System
  def update
    @scene.collection(:transform, :spinner).each do |data|
      data => {transform:}
      #transform.rotation.x = glfwGetTime() * 30
      transform.rotation.y = glfwGetTime() * 30
      #transform.rotation.z = glfwGetTime() * 30
    end
  end
end
