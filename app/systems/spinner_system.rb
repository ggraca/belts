class SpinnerSystem
  def initialize(scene)
    @scene = scene
  end

  def update
    @scene.collection(:transform, :spinner).each do |data|
      data => {transform:}
      transform.rotation.x = glfwGetTime() * 50.0
    end
  end
end
