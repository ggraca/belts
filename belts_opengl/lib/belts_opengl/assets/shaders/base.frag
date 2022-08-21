#version 330 core
out vec4 FragColor;

in vec3 normal;
in vec3 curPosition;

void main() {
  vec4 objColor = vec4(1.0, 0.5, 1, 1);
  vec3 lightPosition = vec3(0, 0, -10);
  vec4 lightColor = vec4(1, 1, 1, 1);
  float ambient = 0.0;

  vec3 norm = normalize(normal);
  vec3 lightDirection = normalize(lightPosition - curPosition);

  float diffuse = max(dot(norm, lightDirection), 0.0f);

  FragColor = objColor * lightColor * (diffuse + ambient);
}
