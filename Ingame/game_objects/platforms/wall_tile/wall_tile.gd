extends StaticBody2D
@tool

@export_dir var textures_directory : String:
	get:
		return textures_directory
	set(value):
		if textures_directory == value: return
		textures_directory = value
		_update_sprite()

@onready var sprite   : Sprite2D = $sprite

func level_listener_on_ready(level_data : Dictionary) -> void:
	if level_data.has("skin"):
		textures_directory = level_data.skin.textures_directory
		_update_sprite()

func _update_sprite() -> void:
	if not is_instance_valid(sprite): return
	sprite.texture = load(textures_directory + "/wall-tile.png")

	_random_region_texture() 

func _random_region_texture() -> void:
	if sprite.texture:
		var num_tiles = sprite.texture.get_width() / int(sprite.region_rect.size.x)
		var skips : int = randi() % num_tiles
		sprite.region_rect.position.x = skips * sprite.region_rect.size.x

func _ready() -> void:
	if Engine.is_editor_hint():
		call_deferred("_update_sprite")
