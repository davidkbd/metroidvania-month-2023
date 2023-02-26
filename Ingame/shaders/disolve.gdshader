shader_type canvas_item;

uniform sampler2D dissolve_texture : source_color;
uniform float dissolve_value : hint_range(0,1);
uniform int animation_columns = 1;
uniform int animation_rows = 1;

void fragment(){
	vec2 uv = UV;
	uv.x *= float(animation_columns);
	uv.y *= float(animation_rows);
	vec4 main_texture = texture(TEXTURE, UV);
	vec4 noise_texture = texture(dissolve_texture, uv);
	main_texture.a *= floor(dissolve_value + min(1, noise_texture.x));
	COLOR = main_texture;
}