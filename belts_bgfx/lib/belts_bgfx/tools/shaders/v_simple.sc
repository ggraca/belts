$input a_position, a_normal
$output v_worldPos, v_viewPos, v_normal

#include <bgfx_shader.sh>

void main()
{
	gl_Position = u_modelViewProj * vec4(a_position, 1.0);
	v_worldPos = (u_model[0] * vec4(a_position, 1.0)).xyz;
	v_viewPos = (u_viewProj * vec4(a_position, 1.0)).xyz;
	v_normal = vec3(u_modelView * vec4(a_normal, 0.0));
}
