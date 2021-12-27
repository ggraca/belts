class Renderers::MeshRenderers::Square
  class << self
    def draw(transform, render_data)
      color = render_data.color || Float3.up

      glLoadIdentity()
      glTranslatef(*transform.position.values)
      glScalef(*transform.scale.values)
      glRotatef(*transform.rotation.values, 1.0)
      glBegin(GL_TRIANGLES)
      glColor3f(*color)

      glVertex3f(-0.5, 0.5, 0.0)
      glVertex3f(0.5, 0.5, 0.0)
      glVertex3f(0.5, -0.5, 0.0)

      glVertex3f(0.5, -0.5, 0.0)
      glVertex3f(-0.5, -0.5, 0.0)
      glVertex3f(-0.5, 0.5, 0.0)

      glEnd()
    end
  end
end
