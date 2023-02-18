extends Node2D
@tool

@export_category("Content")
@export_multiline var text  : String = "hola amijo\nhola" : 
	get: return text
	set(value):
		if value == text: return
		text = value
		queue_redraw()
@export var bold  : bool = false : 
	get: return bold
	set(value):
		if value == bold: return
		bold = value
		queue_redraw()
@export var width : int = 64 : 
	get: return width
	set(value):
		if value == width: return
		width = value
		queue_redraw()

@export_category("Graphics")
@export var first_half_color : Color = Color.LIGHT_GRAY :
	get: return first_half_color
	set(value):
		if value == first_half_color: return
		first_half_color = value
		queue_redraw()
@export var last_half_color  : Color = Color.GRAY :
	get: return last_half_color
	set(value):
		if value == last_half_color: return
		last_half_color = value
		queue_redraw()
@export var shadow_color     : Color = Color("#272727") :
	get: return shadow_color
	set(value):
		if value == shadow_color: return
		shadow_color = value
		queue_redraw()

@export_category("Internal")
@export var bitmap : Texture2D

const CHAR_WIDTH  : float = 9.0
const CHAR_HEIGHT : float = 11.0

const CHAR_METADATA : Dictionary = {
	"normal": {
		"A": { "width": 8, "pos": 0 },
		"B": { "width": 8, "pos": 1 },
		"C": { "width": 8, "pos": 2 },
		"D": { "width": 8, "pos": 3 },
		"E": { "width": 8, "pos": 4 },
		"F": { "width": 8, "pos": 5 },
		"G": { "width": 8, "pos": 6 },
		"H": { "width": 8, "pos": 7 },
		"I": { "width": 6, "pos": 8 },
		"J": { "width": 8, "pos": 9 },
		"K": { "width": 8, "pos": 10 },
		"L": { "width": 8, "pos": 11 },
		"M": { "width": 9, "pos": 12 },
		"N": { "width": 8, "pos": 13 },
		"O": { "width": 8, "pos": 14 },
		"P": { "width": 8, "pos": 15 },
		"Q": { "width": 8, "pos": 16 },
		"R": { "width": 8, "pos": 17 },
		"S": { "width": 8, "pos": 18 },
		"T": { "width": 8, "pos": 19 },
		"U": { "width": 8, "pos": 20 },
		"V": { "width": 8, "pos": 21 },
		"W": { "width": 9, "pos": 22 },
		"X": { "width": 8, "pos": 23 },
		"Y": { "width": 8, "pos": 24 },
		"Z": { "width": 8, "pos": 25 },
		"a": { "width": 8, "pos": 26 },
		"b": { "width": 8, "pos": 27 },
		"c": { "width": 8, "pos": 28 },
		"d": { "width": 8, "pos": 29 },
		"e": { "width": 8, "pos": 30 },
		"f": { "width": 6, "pos": 31 },
		"g": { "width": 8, "pos": 32 },
		"h": { "width": 8, "pos": 33 },
		"i": { "width": 5, "pos": 34 },
		"j": { "width": 8, "pos": 35 },
		"k": { "width": 8, "pos": 36 },
		"l": { "width": 5, "pos": 37 },
		"m": { "width": 9, "pos": 38 },
		"n": { "width": 8, "pos": 39 },
		"ñ": { "width": 8, "pos": 39 },
		"o": { "width": 8, "pos": 40 },
		"p": { "width": 8, "pos": 41 },
		"q": { "width": 8, "pos": 42 },
		"r": { "width": 7, "pos": 43 },
		"s": { "width": 8, "pos": 44 },
		"t": { "width": 7, "pos": 45 },
		"u": { "width": 8, "pos": 46 },
		"v": { "width": 8, "pos": 47 },
		"w": { "width": 9, "pos": 48 },
		"x": { "width": 8, "pos": 49 },
		"y": { "width": 8, "pos": 50 },
		"z": { "width": 8, "pos": 51 },
		"0": { "width": 8, "pos": 52 },
		"1": { "width": 8, "pos": 53 },
		"2": { "width": 8, "pos": 54 },
		"3": { "width": 8, "pos": 55 },
		"4": { "width": 8, "pos": 56 },
		"5": { "width": 8, "pos": 57 },
		"6": { "width": 8, "pos": 58 },
		"7": { "width": 8, "pos": 59 },
		"8": { "width": 8, "pos": 60 },
		"9": { "width": 8, "pos": 61 },
		" ": { "width": 8, "pos": 62 },
		"\n": { "width": 0, "pos": 62 }
	},
	"bold": {
		"A": { "width": 8, "pos": 0 },
		"B": { "width": 8, "pos": 1 },
		"C": { "width": 8, "pos": 2 },
		"D": { "width": 8, "pos": 3 },
		"E": { "width": 8, "pos": 4 },
		"F": { "width": 8, "pos": 5 },
		"G": { "width": 8, "pos": 6 },
		"H": { "width": 8, "pos": 7 },
		"I": { "width": 7, "pos": 8 },
		"J": { "width": 8, "pos": 9 },
		"K": { "width": 8, "pos": 10 },
		"L": { "width": 8, "pos": 11 },
		"M": { "width": 9, "pos": 12 },
		"N": { "width": 9, "pos": 13 },
		"O": { "width": 8, "pos": 14 },
		"P": { "width": 8, "pos": 15 },
		"Q": { "width": 8, "pos": 16 },
		"R": { "width": 8, "pos": 17 },
		"S": { "width": 8, "pos": 18 },
		"T": { "width": 8, "pos": 19 },
		"U": { "width": 8, "pos": 20 },
		"V": { "width": 8, "pos": 21 },
		"W": { "width": 9, "pos": 22 },
		"X": { "width": 8, "pos": 23 },
		"Y": { "width": 8, "pos": 24 },
		"Z": { "width": 8, "pos": 25 },
		"a": { "width": 8, "pos": 26 },
		"b": { "width": 8, "pos": 27 },
		"c": { "width": 8, "pos": 28 },
		"d": { "width": 8, "pos": 29 },
		"e": { "width": 8, "pos": 30 },
		"f": { "width": 7, "pos": 31 },
		"g": { "width": 8, "pos": 32 },
		"h": { "width": 8, "pos": 33 },
		"i": { "width": 6, "pos": 34 },
		"j": { "width": 8, "pos": 35 },
		"k": { "width": 8, "pos": 36 },
		"l": { "width": 6, "pos": 37 },
		"m": { "width": 9, "pos": 38 },
		"n": { "width": 8, "pos": 39 },
		"o": { "width": 8, "pos": 40 },
		"p": { "width": 8, "pos": 41 },
		"q": { "width": 8, "pos": 42 },
		"r": { "width": 8, "pos": 43 },
		"s": { "width": 8, "pos": 44 },
		"t": { "width": 7, "pos": 45 },
		"u": { "width": 8, "pos": 46 },
		"v": { "width": 8, "pos": 47 },
		"w": { "width": 9, "pos": 48 },
		"x": { "width": 8, "pos": 49 },
		"y": { "width": 8, "pos": 50 },
		"z": { "width": 8, "pos": 51 },
		"0": { "width": 8, "pos": 52 },
		"1": { "width": 8, "pos": 53 },
		"2": { "width": 8, "pos": 54 },
		"3": { "width": 8, "pos": 55 },
		"4": { "width": 8, "pos": 56 },
		"5": { "width": 8, "pos": 57 },
		"6": { "width": 8, "pos": 58 },
		"7": { "width": 8, "pos": 59 },
		"8": { "width": 8, "pos": 60 },
		"9": { "width": 8, "pos": 61 },
		" ": { "width": 8, "pos": 62 },
		"\n": { "width": 0, "pos": 62 }
	},
	
}

func _print_char(_x : int, _y : int, _w : int, _char_pos : int) -> void:
	var char_posy = CHAR_HEIGHT if bold else .0
	var char_region : Rect2 = Rect2(_char_pos * CHAR_WIDTH, char_posy, _w, CHAR_HEIGHT)
	var rect_position : Rect2 = Rect2(_x, _y, 9.0, 11.0)
	draw_texture_rect_region(bitmap, rect_position, char_region)

func _configure_colors() -> void:
	material.set_shader_parameter("color1", first_half_color)
	material.set_shader_parameter("color2", last_half_color)
	material.set_shader_parameter("color3", shadow_color)

func _calculate_width_lines(_text : String) -> Array[int]:
	var r : Array[int] = []
	
	var width_chars : Array[int] = []

	for l in _text:
		var md = CHAR_METADATA.bold[l] if bold else CHAR_METADATA.normal[l]
		width_chars.append(md.width)

	var l : String
	var i : int = 0
	var w : int = 0
	var space_position : int = -1
	while i < _text.length():
		w += width_chars[i]
		l = _text[i]
		if l == '\n':
			r.append(w)
			w = 0
			space_position = -1
		elif w < width and l == " ":
			space_position = i
		if w >= width:
			if space_position == -1:
				if l == " ":
					r.append(w)
					w = 0
					space_position = -1
			else:
				while w >= width or l != " ":
					l = _text[i]
					w -= width_chars[i]
					i -= 1
				i += 1
				r.append(w)
				w = 0
				space_position = -1
		i += 1
	r.append(w)
	
	return r

func _draw():
	_configure_colors()

	var text_to_parse = text#.trim_suffix(" ")

	var widths : Array[int] = _calculate_width_lines(text_to_parse)
	var x : int = 0
	var y : int = 0
	var height_i : int = 0
	var md : Dictionary
	if bold:
		md = CHAR_METADATA.bold
	else:
		md = CHAR_METADATA.normal
	for l in text_to_parse:
		var char_md = md[l]
		if x >= widths[height_i]:
			height_i += 1
			y += CHAR_HEIGHT
			x = -char_md.width if l == " " else 0
		_print_char(x, y, char_md.width, char_md.pos)
		x += char_md.width
