class Renderers::MeshRenderers::Cube
  class << self
    def draw(transform, render_data)
      color = render_data.color || Float3.up

      glLoadIdentity()
      glTranslatef(*transform.position.values)
      glScalef(*transform.scale.values)
      glRotatef(*transform.rotation.values, 1.0)
      glBegin(GL_TRIANGLES)
      glColor3f(*color)

      draw_cube_faces

      glEnd()
    end

    def draw_cube_faces
      cube_vertices = [
        # Back face (clockwise winding)
        [-0.5, 0.5, -0.5],
        [0.5, 0.5, -0.5],
        [0.5, -0.5, -0.5],
        [-0.5, -0.5, -0.5],

        # Front face (counter-clockwise winding)
        [-0.5, 0.5, 0.5],
        [0.5, 0.5, 0.5],
        [0.5, -0.5, 0.5],
        [-0.5, -0.5, 0.5]
      ]

      # Back face
      glVertex3f(*cube_vertices[0])
      glVertex3f(*cube_vertices[1])
      glVertex3f(*cube_vertices[2])
      glVertex3f(*cube_vertices[2])
      glVertex3f(*cube_vertices[3])
      glVertex3f(*cube_vertices[0])

      # Front face
      glVertex3f(*cube_vertices[5])
      glVertex3f(*cube_vertices[4])
      glVertex3f(*cube_vertices[7])
      glVertex3f(*cube_vertices[7])
      glVertex3f(*cube_vertices[6])
      glVertex3f(*cube_vertices[5])

      # Top face
      glVertex3f(*cube_vertices[4])
      glVertex3f(*cube_vertices[5])
      glVertex3f(*cube_vertices[1])
      glVertex3f(*cube_vertices[1])
      glVertex3f(*cube_vertices[0])
      glVertex3f(*cube_vertices[4])

      # Bottom face
      glVertex3f(*cube_vertices[3])
      glVertex3f(*cube_vertices[2])
      glVertex3f(*cube_vertices[6])
      glVertex3f(*cube_vertices[6])
      glVertex3f(*cube_vertices[7])
      glVertex3f(*cube_vertices[3])

      # Left face
      glVertex3f(*cube_vertices[4])
      glVertex3f(*cube_vertices[0])
      glVertex3f(*cube_vertices[3])
      glVertex3f(*cube_vertices[3])
      glVertex3f(*cube_vertices[7])
      glVertex3f(*cube_vertices[4])

      # Right face
      glVertex3f(*cube_vertices[1])
      glVertex3f(*cube_vertices[5])
      glVertex3f(*cube_vertices[6])
      glVertex3f(*cube_vertices[6])
      glVertex3f(*cube_vertices[2])
      glVertex3f(*cube_vertices[1])
    end
  end
end
