class SnakeMovementSystem < System
  collection :snakes,
    with: [:transform, :snake_data]

  def update
    snakes.each do |data|
      @last_time ||= glfwGetTime()
      delta = glfwGetTime() - @last_time
      @last_time = glfwGetTime()
      @timer ||= 0.0
      @timer += delta

      return if @timer < 1
      @timer = 0.0

      data => {transform:}
      transform.position.x += 1
    end
  end
end
