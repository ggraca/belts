$input a_position, a_normal, a_color0
$output v_normal, v_pos, v_view, v_color0

#include <bgfx_shader.sh>

void main()
{
	gl_Position = u_modelViewProj * vec4(a_position, 1.0);
	v_pos = (u_model[0] * vec4(a_position, 1.0)).xyz;
	v_view = mul(u_modelView, vec4(a_position, 1.0)).xyz;
  v_normal = a_normal;
	v_color0 = a_color0;
}
