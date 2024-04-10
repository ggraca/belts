$input a_position, a_normal, a_tangent, a_bitangent, a_texcoord0
$output v_position, v_normal, v_tangent, v_bitangent, v_texcoord0

#include <bgfx_shader.sh>

void main() {
	v_position = (u_model[0] * vec4(a_position, 1.0)).xyz;
	v_normal = (u_model[0] * vec4(a_normal, 0)).xyz;
	v_tangent = (u_model[0] * vec4(a_tangent, 0)).xyz;
	v_bitangent = (u_model[0] * vec4(a_bitangent, 0)).xyz;
	v_texcoord0 = a_texcoord0;

	gl_Position = u_modelViewProj * vec4(a_position, 1.0);
}
