#version 330 core
out vec4 FragColor;

in vec3 normal;
in vec3 curPosition;

void main() {
  float ambient = 0.2;
  vec3 lightPosition = vec3(2.0, 2.0, 2.0);
  vec3 lightDirection = normalize(lightPosition - curPosition);

  float diffuse = max(dot(normal, lightDirection), 0.0);
  vec4 objColor = vec4(1.0, 1.0, 0.5, 1);
  vec4 lightColor = vec4(1, 1, 1, 1);

  FragColor = objColor * lightColor * (diffuse + ambient);
}
