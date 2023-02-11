$input v_normal, v_worldPos, v_viewPos

uniform vec4 u_badjoras;

#include <bgfx_shader.sh>

void main()
{
	vec3 objectColor = u_badjoras.rgb;
  vec3 lightPosition = vec3(3, 0, 1);
  vec3 lightColor = vec3(1, 1, 1);
	float ambientStrength = 0.1;
	float specularStrength = 0.5;

	vec3 norm = normalize(v_normal);
	vec3 lightDir = normalize(lightPosition - v_worldPos);
	vec3 viewDir = normalize(v_viewPos - v_worldPos);
	vec3 reflectDir = reflect(-lightDir, norm);

	float diff = max(dot(norm, lightDir), 0.0);
	float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);

  vec3 ambient = ambientStrength * lightColor;
	vec3 diffuse = diff * lightColor;
	vec3 specular = specularStrength * spec * lightColor;

  vec3 result = (ambient + diffuse + specular) * objectColor;
  gl_FragColor = vec4(result, 1);
}
