extends Node2D
@tool


enum PipeType {
	ELBOW, TILE
}
enum Direction {
	NORTH, EAST, SOUTH, WEST
}

@export_dir var textures_directory : String:
	get:
		return textures_directory
	set(value):
		if textures_directory == value: return
		textures_directory = value
		_update_sprite()

@export var pipe_type : PipeType = PipeType.TILE :
	get:
		return pipe_type
	set(value):
		if pipe_type == value: return
		pipe_type = value
		_update_sprite()

@export var direction : Direction = Direction.NORTH :
	get:
		return direction
	set(value):
		if direction == value: return
		direction = value
		_update_sprite()

@onready var sprite   : Sprite2D = $sprite

func level_listener_on_ready(level_data : Dictionary) -> void:
	if level_data.has("skin"):
		textures_directory = level_data.skin.textures_directory
		_update_sprite()

func _update_sprite() -> void:
	if not is_instance_valid(sprite): return
	if textures_directory == "": return
	
	
	sprite.rotation = (-PI / 2.0) * direction - PI
	sprite.region_rect.size.y = 8 if pipe_type == PipeType.ELBOW else 32
	
	match pipe_type:
		PipeType.TILE:       sprite.texture = load(textures_directory + "/pipe-tile.png")
		PipeType.ELBOW:      sprite.texture = load(textures_directory + "/pipe-elbow.png")
	
	_random_region_texture()

func _random_region_texture() -> void:
	if sprite.texture:
		var num_tiles = floor(sprite.texture.get_width()) / int(sprite.region_rect.size.x)
		var skips : int = randi() % num_tiles
		sprite.region_rect.position.x = skips * sprite.region_rect.size.x

func _ready() -> void:
	if Engine.is_editor_hint():
		call_deferred("_update_sprite")
