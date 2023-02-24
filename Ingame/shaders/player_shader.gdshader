shader_type canvas_item;

uniform sampler2D tex : source_color,repeat_enable,filter_nearest;
uniform float timescale = .25;
uniform int animation_columns = 11;
uniform int animation_rows    = 11;


void fragment() {
	vec4 sprite_color = COLOR;
	vec2 uv = UV;
	uv.x *= float(animation_columns);
	uv.y *= float(animation_rows);
	uv = vec2(uv.x * 6.0, uv.y * 6.0 + TIME * timescale);
	vec4 t = texture(tex, uv);
	if (sprite_color.a != .0) {
		sprite_color.rgba += vec4(t.a, t.a, t.a, t.a) * .1;
	}
	COLOR = sprite_color;
}
