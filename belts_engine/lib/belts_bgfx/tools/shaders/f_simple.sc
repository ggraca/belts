$input v_position, v_normal, v_viewPos, v_texcoord0

#include <bgfx_shader.sh>
#include <common.sh>
#include <phong.sh>
#include <pbr.sh>

SAMPLER2D(s_tex_color, 0);

uniform vec4 u_color;
uniform vec4 u_surface;

#define u_roughness u_surface.x
#define u_metallness u_surface.y

void main() {
	vec3 base = toLinear(texture2D(s_tex_color, v_texcoord0)).rgb;

	vec3 F0 = mix(vec3(0.04), base, u_metallness);
	vec3 V = normalize(v_viewPos - v_position);
	vec3 N = normalize(v_normal);

	vec3 directLighting = vec3(0);
	// TODO: support more lights
	for(int i=0; i<1; ++i)
	{
		vec3 lightPosition = vec3(-10, 10, -10);
  	vec3 lightColor = vec3(1, 1, 1);
		vec3 L = normalize(lightPosition - v_position);

		// directLighting += phong(N, L, V, base) * lightColor;
		directLighting += PBR(N, L, V, F0, u_roughness, u_metallness, base) * lightColor;
	}

  gl_FragColor = vec4(directLighting, 1);
}
