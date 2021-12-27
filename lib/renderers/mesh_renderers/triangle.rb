class Renderers::MeshRenderers::Triangle
  class << self
    def draw(transform, render_data)
      color = Float3.up
      color = Float3.right if render_data.color == :red

      glLoadIdentity()
      glTranslatef(*transform.position.values)
      glRotatef(*transform.rotation.values, 1.0)
      glBegin(GL_TRIANGLES)
      glColor3f(*color)
      glVertex3f(-0.6, -0.4, 0.0)
      glVertex3f(0.6, -0.4, 0.0)
      glVertex3f(0.0, 0.6, 0.0)
      glEnd()
    end
  end
end
