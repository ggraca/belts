$input a_position, a_normal, a_tangent, a_bitangent, a_texcoord0
$output v_position, v_normal, v_tangent, v_bitangent, v_texcoord0

#include <bgfx_shader.sh>

void main() {
	v_position = (u_model[0] * vec4(a_position, 1.0)).xyz;
	v_normal = mat3(u_model[0]) * a_normal;
	v_tangent = mat3(u_model[0]) * a_tangent;
	v_bitangent = mat3(u_model[0]) * a_bitangent;
	v_texcoord0 = a_texcoord0;

	gl_Position = u_modelViewProj * vec4(a_position, 1.0);
}
