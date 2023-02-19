extends Node2D
class_name PixelLabel
@tool

@export_category("Content")
@export_multiline var text  : String = "" : 
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
@export var centered : bool = false :
	get: return centered
	set(value):
		if value == centered: return
		centered = value
		queue_redraw()
@export var vertical_centered : bool = false :
	get: return vertical_centered
	set(value):
		if value == vertical_centered: return
		vertical_centered = value
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

func _get_char_metadata(_char : String) -> Dictionary:
	if bold:
		match _char:
			"A": return { "width": 8, "pos": 0 }
			"B": return { "width": 8, "pos": 1 }
			"C": return { "width": 8, "pos": 2 }
			"D": return { "width": 8, "pos": 3 }
			"E": return { "width": 8, "pos": 4 }
			"F": return { "width": 8, "pos": 5 }
			"G": return { "width": 8, "pos": 6 }
			"H": return { "width": 8, "pos": 7 }
			"I": return { "width": 7, "pos": 8 }
			"J": return { "width": 8, "pos": 9 }
			"K": return { "width": 8, "pos": 10 }
			"L": return { "width": 8, "pos": 11 }
			"M": return { "width": 9, "pos": 12 }
			"N": return { "width": 9, "pos": 13 }
			"O": return { "width": 8, "pos": 14 }
			"P": return { "width": 8, "pos": 15 }
			"Q": return { "width": 8, "pos": 16 }
			"R": return { "width": 8, "pos": 17 }
			"S": return { "width": 8, "pos": 18 }
			"T": return { "width": 8, "pos": 19 }
			"U": return { "width": 8, "pos": 20 }
			"V": return { "width": 8, "pos": 21 }
			"W": return { "width": 9, "pos": 22 }
			"X": return { "width": 8, "pos": 23 }
			"Y": return { "width": 8, "pos": 24 }
			"Z": return { "width": 8, "pos": 25 }
			"a": return { "width": 8, "pos": 26 }
			"b": return { "width": 8, "pos": 27 }
			"c": return { "width": 8, "pos": 28 }
			"d": return { "width": 8, "pos": 29 }
			"e": return { "width": 8, "pos": 30 }
			"f": return { "width": 7, "pos": 31 }
			"g": return { "width": 8, "pos": 32 }
			"h": return { "width": 8, "pos": 33 }
			"i": return { "width": 6, "pos": 34 }
			"j": return { "width": 8, "pos": 35 }
			"k": return { "width": 8, "pos": 36 }
			"l": return { "width": 6, "pos": 37 }
			"m": return { "width": 9, "pos": 38 }
			"n": return { "width": 8, "pos": 39 }
			"o": return { "width": 8, "pos": 40 }
			"p": return { "width": 8, "pos": 41 }
			"q": return { "width": 8, "pos": 42 }
			"r": return { "width": 8, "pos": 43 }
			"s": return { "width": 8, "pos": 44 }
			"t": return { "width": 7, "pos": 45 }
			"u": return { "width": 8, "pos": 46 }
			"v": return { "width": 8, "pos": 47 }
			"w": return { "width": 9, "pos": 48 }
			"x": return { "width": 8, "pos": 49 }
			"y": return { "width": 8, "pos": 50 }
			"z": return { "width": 8, "pos": 51 }
			"0": return { "width": 8, "pos": 52 }
			"1": return { "width": 8, "pos": 53 }
			"2": return { "width": 8, "pos": 54 }
			"3": return { "width": 8, "pos": 55 }
			"4": return { "width": 8, "pos": 56 }
			"5": return { "width": 8, "pos": 57 }
			"6": return { "width": 8, "pos": 58 }
			"7": return { "width": 8, "pos": 59 }
			"8": return { "width": 8, "pos": 60 }
			"9": return { "width": 8, "pos": 61 }
			" ": return { "width": 8, "pos": 62 }
			"\n": return { "width": 0, "pos": 62 }
			";": return { "width": 5, "pos": 63 }
			".": return { "width": 5, "pos": 64 }
			":": return { "width": 6, "pos": 65 }
			"'": return { "width": 5, "pos": 66 }
			"\"": return { "width": 5, "pos": 67 }
			"(": return { "width": 5, "pos": 68 }
			"!": return { "width": 5, "pos": 69 }
			"?": return { "width": 5, "pos": 70 }
			")": return { "width": 5, "pos": 71 }
			"+": return { "width": 5, "pos": 72 }
			"-": return { "width": 6, "pos": 73 }
			"^": return { "width": 5, "pos": 74 }
			"/": return { "width": 5, "pos": 75 }
			"=": return { "width": 5, "pos": 76 }
	else:
		match _char:
			"A": return { "width": 8, "pos": 0 }
			"B": return { "width": 8, "pos": 1 }
			"C": return { "width": 8, "pos": 2 }
			"D": return { "width": 8, "pos": 3 }
			"E": return { "width": 8, "pos": 4 }
			"F": return { "width": 8, "pos": 5 }
			"G": return { "width": 8, "pos": 6 }
			"H": return { "width": 8, "pos": 7 }
			"I": return { "width": 6, "pos": 8 }
			"J": return { "width": 8, "pos": 9 }
			"K": return { "width": 8, "pos": 10 }
			"L": return { "width": 8, "pos": 11 }
			"M": return { "width": 9, "pos": 12 }
			"N": return { "width": 8, "pos": 13 }
			"O": return { "width": 8, "pos": 14 }
			"P": return { "width": 8, "pos": 15 }
			"Q": return { "width": 8, "pos": 16 }
			"R": return { "width": 8, "pos": 17 }
			"S": return { "width": 8, "pos": 18 }
			"T": return { "width": 8, "pos": 19 }
			"U": return { "width": 8, "pos": 20 }
			"V": return { "width": 8, "pos": 21 }
			"W": return { "width": 9, "pos": 22 }
			"X": return { "width": 8, "pos": 23 }
			"Y": return { "width": 8, "pos": 24 }
			"Z": return { "width": 8, "pos": 25 }
			"a": return { "width": 8, "pos": 26 }
			"b": return { "width": 8, "pos": 27 }
			"c": return { "width": 8, "pos": 28 }
			"d": return { "width": 8, "pos": 29 }
			"e": return { "width": 8, "pos": 30 }
			"f": return { "width": 6, "pos": 31 }
			"g": return { "width": 8, "pos": 32 }
			"h": return { "width": 8, "pos": 33 }
			"i": return { "width": 5, "pos": 34 }
			"j": return { "width": 8, "pos": 35 }
			"k": return { "width": 8, "pos": 36 }
			"l": return { "width": 5, "pos": 37 }
			"m": return { "width": 9, "pos": 38 }
			"n": return { "width": 8, "pos": 39 }
			"ñ": return { "width": 8, "pos": 39 }
			"o": return { "width": 8, "pos": 40 }
			"p": return { "width": 8, "pos": 41 }
			"q": return { "width": 8, "pos": 42 }
			"r": return { "width": 7, "pos": 43 }
			"s": return { "width": 8, "pos": 44 }
			"t": return { "width": 7, "pos": 45 }
			"u": return { "width": 8, "pos": 46 }
			"v": return { "width": 8, "pos": 47 }
			"w": return { "width": 9, "pos": 48 }
			"x": return { "width": 8, "pos": 49 }
			"y": return { "width": 8, "pos": 50 }
			"z": return { "width": 8, "pos": 51 }
			"0": return { "width": 8, "pos": 52 }
			"1": return { "width": 8, "pos": 53 }
			"2": return { "width": 8, "pos": 54 }
			"3": return { "width": 8, "pos": 55 }
			"4": return { "width": 8, "pos": 56 }
			"5": return { "width": 8, "pos": 57 }
			"6": return { "width": 8, "pos": 58 }
			"7": return { "width": 8, "pos": 59 }
			"8": return { "width": 8, "pos": 60 }
			"9": return { "width": 8, "pos": 61 }
			" ": return { "width": 8, "pos": 62 }
			"\n": return { "width": 0, "pos": 62 }
			";": return { "width": 5, "pos": 63 }
			".": return { "width": 5, "pos": 64 }
			":": return { "width": 6, "pos": 65 }
			"'": return { "width": 5, "pos": 66 }
			"\"": return { "width": 5, "pos": 67 }
			"(": return { "width": 5, "pos": 68 }
			"!": return { "width": 5, "pos": 69 }
			"?": return { "width": 5, "pos": 70 }
			")": return { "width": 5, "pos": 71 }
			"+": return { "width": 5, "pos": 72 }
			"-": return { "width": 6, "pos": 73 }
			"^": return { "width": 5, "pos": 74 }
			"/": return { "width": 5, "pos": 75 }
			"=": return { "width": 5, "pos": 76 }
	return { "width": 8, "pos": 70 }

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
		var md = _get_char_metadata(l)
		if md.size() == 0:
			width_chars.append(0)
		else:
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

	var text_to_parse = text

	var widths : Array[int] = _calculate_width_lines(text_to_parse)
	var x : int = 0
	var y : int = 0
	var height_i : int = 0

	for l in text_to_parse:
		var char_md = _get_char_metadata(l)
		if char_md.size() > 0:
			if x >= widths[height_i]:
				height_i += 1
				y += CHAR_HEIGHT
				x = -char_md.width if l == " " else 0
			_print_char(x - widths[height_i] / 2 if centered else x, y - widths.size() * CHAR_HEIGHT / 2 if vertical_centered else y, char_md.width, char_md.pos)
			x += char_md.width
