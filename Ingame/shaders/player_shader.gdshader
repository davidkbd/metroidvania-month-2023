shader_type canvas_item;

uniform sampler2D tex : source_color,repeat_enable,filter_nearest;
uniform float timescale = .25;


void fragment() {
	vec4 sprite_color = COLOR;
	vec2 uv = vec2(UV.x, UV.y + TIME * timescale);
	vec4 t = texture(tex, uv);
	if (sprite_color.a != .0) {
		sprite_color.rgba += vec4(t.a, t.a, t.a, t.a) * .1;
	}
	COLOR = sprite_color;
}
