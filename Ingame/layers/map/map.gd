extends Node2D

@export var offset : Vector2 = Vector2.ZERO

@onready var MAP_IMAGES : Dictionary = _preload_pngs()

const PATH = "map-%s%s.png"

var map_state : Dictionary

func initialize_map_state(_map_state : Dictionary) -> void:
	map_state = _map_state

func _draw():
	var room : Dictionary
	var path : String
	var res  : CompressedTexture2D
	var pos  : Vector2
	for key in map_state:
		room = map_state[key]
		if room.visible:
			pos = Vector2(room.position_x, room.position_y)
			var secrets = "" if room.variation == 0 else "-SECRETS"
			draw_texture(MAP_IMAGES[PATH % [key,secrets]], floor(pos * .08) + offset)

func _preload_pngs() -> Dictionary:
	var r : Dictionary = {}
	r["map-room_001_combat.png"]=preload("res://Ingame/rooms/map-pngs/map-room_001_combat.png")
	r["map-room_001.png"]=preload("res://Ingame/rooms/map-pngs/map-room_001.png")
	r["map-room_001_secret.png"]=preload("res://Ingame/rooms/map-pngs/map-room_001_secret.png")
	r["map-room_001-SECRETS.png"]=preload("res://Ingame/rooms/map-pngs/map-room_001-SECRETS.png")
	r["map-room_002.png"]=preload("res://Ingame/rooms/map-pngs/map-room_002.png")
	r["map-room_002_secret.png"]=preload("res://Ingame/rooms/map-pngs/map-room_002_secret.png")
	r["map-room_002_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_002_tunnel.png")
	r["map-room_003.png"]=preload("res://Ingame/rooms/map-pngs/map-room_003.png")
	r["map-room_003_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_003_tunnel.png")
	r["map-room_004.png"]=preload("res://Ingame/rooms/map-pngs/map-room_004.png")
	r["map-room_004_savepoint.png"]=preload("res://Ingame/rooms/map-pngs/map-room_004_savepoint.png")
	r["map-room_004_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_004_tunnel.png")
	r["map-room_006.png"]=preload("res://Ingame/rooms/map-pngs/map-room_006.png")
	r["map-room_006_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_006_tunnel.png")
	r["map-room_007.png"]=preload("res://Ingame/rooms/map-pngs/map-room_007.png")
	r["map-room_008.png"]=preload("res://Ingame/rooms/map-pngs/map-room_008.png")
	r["map-room_008-SECRETS.png"]=preload("res://Ingame/rooms/map-pngs/map-room_008-SECRETS.png")
	r["map-room_009.png"]=preload("res://Ingame/rooms/map-pngs/map-room_009.png")
	r["map-room_009-SECRETS.png"]=preload("res://Ingame/rooms/map-pngs/map-room_009-SECRETS.png")
	r["map-room_009_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_009_tunnel.png")
	r["map-room_010_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_010_tunnel.png")
	r["map-room_011.png"]=preload("res://Ingame/rooms/map-pngs/map-room_011.png")
	r["map-room_012_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_012_tunnel.png")
	r["map-room_013.png"]=preload("res://Ingame/rooms/map-pngs/map-room_013.png")
	r["map-room_013_secret.png"]=preload("res://Ingame/rooms/map-pngs/map-room_013_secret.png")
	r["map-room_013-SECRETS.png"]=preload("res://Ingame/rooms/map-pngs/map-room_013-SECRETS.png")
	r["map-room_014.png"]=preload("res://Ingame/rooms/map-pngs/map-room_014.png")
	r["map-room_015.png"]=preload("res://Ingame/rooms/map-pngs/map-room_015.png")
	r["map-room_016.png"]=preload("res://Ingame/rooms/map-pngs/map-room_016.png")
	r["map-room_016_savepoint.png"]=preload("res://Ingame/rooms/map-pngs/map-room_016_savepoint.png")
	r["map-room_016_tunnel.png"]=preload("res://Ingame/rooms/map-pngs/map-room_016_tunnel.png")
	r["map-room_017.png"]=preload("res://Ingame/rooms/map-pngs/map-room_017.png")
	r["map-room_018.png"]=preload("res://Ingame/rooms/map-pngs/map-room_018.png")
	r["map-room_018-SECRETS.png"]=preload("res://Ingame/rooms/map-pngs/map-room_018-SECRETS.png")
	r["map-room_019.png"]=preload("res://Ingame/rooms/map-pngs/map-room_019.png")
	r["map-room_020.png"]=preload("res://Ingame/rooms/map-pngs/map-room_020.png")
	r["map-room_021.png"]=preload("res://Ingame/rooms/map-pngs/map-room_021.png")

	return r
	
	
	var dir = DirAccess.open(Directories.MAP_PNG_PATH)
	print("MAP DIR ", dir)
	print(dir.dir_exists(Directories.MAP_PNG_PATH))
	if dir:
		print("begin")
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.begins_with("map-room") and file_name.ends_with(".png"):
				r[file_name] = load(Directories.MAP_PNG_PATH + file_name)	
				print("file: ", file_name, " r[file_name]: ", r[file_name])
			file_name = dir.get_next()
	return r
