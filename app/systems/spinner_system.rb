class SpinnerSystem < System
  collection :spinners,
    with: [:transform, :spinner]

  def update
    spinners.each do |data|
      data => {transform:}
      #transform.rotation.x = glfwGetTime() * 30
      transform.rotation.y = glfwGetTime() * 30
      #transform.rotation.z = glfwGetTime() * 30
    end
  end
end
