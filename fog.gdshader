shader_type canvas_item;
render_mode blend_add;

uniform sampler2D noise : source_color, filter_nearest, repeat_enable;
uniform float timescale = 1.0;
uniform float min_noise = .3;
uniform float max_noise = .8;
uniform float intensity = .3;
//uniform float color_limit = 4.0;

void fragment() {
	vec2 uv = UV;
	uv.x += TIME * timescale * .1;
	vec4 noise_c = texture(noise, uv);
	float v = (clamp(noise_c.r, min_noise, max_noise) - min_noise) * intensity;
//	v = floor(v * color_limit) / color_limit;
	COLOR.a = v;
}
