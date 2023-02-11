$input v_normal, v_worldPos, v_cameraPos

uniform vec4 u_badjoras;

#include <bgfx_shader.sh>
#include <pbr_functions.sh>

void main()
{
	vec3 base = u_badjoras.rgb;
	float roughness = 1.0;
	float metallic = 0.0;

	vec3 F0 = mix(vec3(0.04), base, metallic);
	vec3 V = normalize(v_cameraPos - v_worldPos);
	vec3 N = normalize(v_normal);

	vec3 directLighting;
	// TODO: support more lights
	for(int i=0; i<1; ++i)
	{
		vec3 lightPosition = vec3(3, 0, -1);
  	vec3 lightColor = vec3(1, 1, 1);
		vec3 L = normalize(lightPosition - v_worldPos);

		directLighting = PBR(N, L, V, F0, roughness, metallic, base);
	}

  gl_FragColor = vec4(directLighting, 1);
}
