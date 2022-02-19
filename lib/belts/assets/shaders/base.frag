#version 330 core
out vec4 FragColor;

in vec3 normal;
in vec4 curPosition;

void main() {
  float ambient = 0.2;
  vec3 lightPosition = vec3(0, 0, -1);
  vec3 lightDirection = normalize(lightPosition - vec3(curPosition));

  float diffuse = max(dot(normal, lightDirection), 0.0);
  vec4 objColor = vec4(1.0, 0.5, 1, 1);
  vec4 lightColor = vec4(1, 1, 1, 1);

  FragColor = objColor * lightColor * (diffuse + ambient);
}
