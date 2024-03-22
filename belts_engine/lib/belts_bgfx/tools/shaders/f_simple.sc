$input v_position, v_normal, v_tangent, v_bitangent, v_texcoord0

#include <bgfx_shader.sh>
#include <common.sh>
#include <phong.sh>
#include <pbr.sh>

#define MAX_LIGHTS 16

SAMPLER2D(s_tex_albedo, 0);
SAMPLER2D(s_tex_normals, 1);
SAMPLER2D(s_tex_roughness, 2);
SAMPLER2D(s_tex_metalness, 3);
SAMPLER2D(s_tex_ambient_occlusion, 4);

uniform vec4 u_camera_position;
uniform vec4 u_lights;
uniform vec4 u_light_positions[MAX_LIGHTS];
uniform vec4 u_light_colors[MAX_LIGHTS];
#define u_total_lights u_lights.x

uniform vec4 u_color;
uniform vec4 u_surface;

void main() {
	mat3 tbn = mat3(normalize(v_tangent), normalize(v_bitangent), normalize(v_normal));

	vec3 albedo = toLinear(texture2D(s_tex_albedo, v_texcoord0)).rgb;
	vec3 normal = texture2D(s_tex_normals, v_texcoord0).rgb * 2.0 - 1.0;
	float roughness = texture2D(s_tex_roughness, v_texcoord0).g;
	float metalness = texture2D(s_tex_metalness, v_texcoord0).b;
	float ao = texture2D(s_tex_ambient_occlusion, v_texcoord0).r;

	vec3 N = normalize(tbn * normal);
	vec3 V = normalize(u_camera_position.xyz - v_position);

	vec3 ambient = vec3(0.1) * albedo * ao;
	vec3 directLighting = vec3(0);
	for(int i=0; i<u_total_lights; ++i) {
		vec3 lightPosition = u_light_positions[i].xyz;
		vec3 L = normalize(lightPosition - v_position);

		float distance = length(lightPosition - v_position);
		float attenuation = 1.0 / (distance * distance);
		vec3 lightColor = u_light_colors[i].xyz * attenuation;

		directLighting += PBR(N, L, V, roughness, metalness, albedo) * lightColor;
	}

	vec3 finalColor = clamp(directLighting + ambient, 0, 1);
  gl_FragColor.xyz = toGamma(finalColor);
}
