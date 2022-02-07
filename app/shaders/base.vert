#version 330 core
layout (location = 0) in vec3 aPosition;
layout (location = 1) in vec3 aNormal;

uniform mat4 camera_matrix;
uniform mat4 model_matrix;
uniform mat4 normal_matrix;

out vec3 normal;
out vec4 curPosition;

void main() {
  normal = mat3(normal_matrix) * aNormal;
  curPosition = model_matrix * vec4(aPosition, 1.0);

  gl_Position = camera_matrix * curPosition;
}
