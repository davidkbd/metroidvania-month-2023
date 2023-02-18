shader_type canvas_item;

uniform bool visible = true;
uniform vec3 color1_to_change : source_color;
uniform vec3 color2_to_change : source_color;
uniform vec3 color3_to_change : source_color;
uniform vec4 color1 : source_color;
uniform vec4 color2 : source_color;
uniform vec4 color3 : source_color;

void fragment() {
	vec4 sprite_color = COLOR;
	if (visible) {
		if (sprite_color.a > .0) {
			if (sprite_color.rgb == color1_to_change.rgb) {
				sprite_color.rgba = color1.rgba;
			} else if (sprite_color.rgb == color2_to_change.rgb) {
				sprite_color.rgba = color2.rgba;
			} else if (sprite_color.rgb == color3_to_change.rgb) {
				sprite_color.rgba = color3.rgba;
			}
		}
	} else {
		if (sprite_color.rgb == color1_to_change.rgb
		|| sprite_color.rgb == color2_to_change.rgb) {
			sprite_color.a = .0;
		}
	}
	COLOR = sprite_color;
}
