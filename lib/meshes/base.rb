class Meshes::Base
  def draw(transform, render_data)
    color = render_data.color || Float3.up

    glLoadIdentity()
    glTranslatef(*transform.position.values)
    glScalef(*transform.scale.values)
    glRotatef(*transform.rotation.values, 1.0)
    glColor3f(*color)
  end
end
