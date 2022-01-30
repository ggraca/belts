#version 330 core
layout (location = 0) in vec3 aPosition;
layout (location = 1) in vec3 aNormal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

out vec3 normal;
out vec3 curPosition;

void main() {
  normal = aNormal;
  curPosition = vec3(model * vec4(aPosition, 1.0));

  gl_Position = view * proj * vec4(curPosition, 1.0);
}

