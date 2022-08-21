#version 330 core
layout (location = 0) in vec3 aPosition;
layout (location = 1) in vec3 aNormal;

uniform mat4 vp_matrix;
uniform mat4 model_matrix;

out vec3 normal;
out vec3 curPosition;

void main() {
  curPosition = vec3(model_matrix * vec4(aPosition, 1.0));

  gl_Position = vp_matrix * vec4(curPosition, 1.0);
  normal = vec3(model_matrix * vec4(aNormal, 1.0));
}
