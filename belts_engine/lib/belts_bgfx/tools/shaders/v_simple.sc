$input a_position, a_normal, a_texcoord0
$output v_position, v_normal, v_viewPos, v_texcoord0

#include <bgfx_shader.sh>

void main() {
	gl_Position = u_modelViewProj * vec4(a_position, 1.0);
	v_position = (u_model[0] * vec4(a_position, 1.0)).xyz;
	v_normal = (u_model[0] * vec4(a_normal, 0.0)).xyz;
	v_viewPos = (u_view * vec4(0, 0, 0, 1.0)).xyz;
	v_texcoord0 = a_texcoord0;
}
