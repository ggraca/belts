class Renderer::MeshRenderers::Triangle
  class << self
    def draw(options = {})
      color = [0.0, 1.0, 0.0]
      color = [1.0, 0.0, 0.0] if options[:color] == :red
      dir = 1
      dir = -1 if options[:flip]

      glLoadIdentity()
      glRotatef(dir * glfwGetTime() * 50.0, 0.0, 0.0, 1.0)
      glBegin(GL_TRIANGLES)
      glColor3f(*color)
      glVertex3f(-0.6, -0.4, 0.0)
      glVertex3f(0.6, -0.4, 0.0)
      glVertex3f(0.0, 0.6, 0.0)
      glEnd()
    end
  end
end
