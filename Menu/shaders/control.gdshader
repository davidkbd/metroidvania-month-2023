shader_type canvas_item;

uniform float timescale : hint_range(.5, 20.0);
uniform vec3 color_to_change : source_color;
uniform vec4 color1 : source_color;
uniform vec4 color2 : source_color;

void fragment() {
	vec4 sprite_color = COLOR;
	if (sprite_color.a > .0) {
		if (sprite_color.rgb == color_to_change.rgb) {
			sprite_color.rgba = mix(color1.rgba, color2.rgba, sin(TIME * timescale) * .5 + .5);
		}
	}

	COLOR = sprite_color;
}
