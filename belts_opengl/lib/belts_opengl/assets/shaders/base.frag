#version 330 core
uniform vec3 camera_position;

out vec4 FragColor;

in vec3 normal;
in vec3 curPosition;

void main() {
  vec4 objColor = vec4(1, 1, 1, 1);
  vec3 lightPosition = vec3(0, 0, -1);
  vec4 lightColor = vec4(0, 1, 1, 1);

  float ambient = 0.2;
  vec3 norm = normalize(normal);
  vec3 lightDirection = normalize(lightPosition - curPosition);

  float specularLight = 0.5;
  float diffuse = max(dot(norm, lightDirection), 0.0f);
  vec3 viewDirection = normalize(camera_position - curPosition);
  vec3 reflectDirection = reflect(-lightDirection, norm);
  float specAmount = pow(max(dot(viewDirection, reflectDirection), 0.0f), 8);
  float specular = specAmount * specularLight;

  FragColor = objColor * lightColor * (diffuse + ambient + specular);
}
