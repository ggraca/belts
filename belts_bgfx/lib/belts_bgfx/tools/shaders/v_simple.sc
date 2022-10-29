$input a_position
$output v_color0

#include <bgfx_shader.sh>

void main()
{
    vec3 curPosition = vec3(mul(u_model[0], vec4(a_position, 1.0)));
    gl_Position = mul(u_viewProj, vec4(curPosition, 1.0));
    v_color0 = vec4(1, 1, 0, 1);
}
