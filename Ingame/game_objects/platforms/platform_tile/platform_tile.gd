extends StaticBody2D
@tool

enum PlatformType {
	LEFT, MIDDLE, RIGHT, BRIDGE
}

@export_dir var textures_directory : String:
	get:
		return textures_directory
	set(value):
		if textures_directory == value: return
		textures_directory = value
		_update_sprite()

@export var platform_type : PlatformType = PlatformType.MIDDLE :
	get:
		return platform_type
	set(value):
		if platform_type == value: return
		platform_type = value
		_update_sprite()
		_update_collider()

@onready var sprite   : Sprite2D = $sprite
@onready var collider : CollisionShape2D = $collider

func level_listener_on_ready(level_data : Dictionary) -> void:
	if level_data.has("skin"):
		textures_directory = level_data.skin.textures_directory
		_update_sprite()

func _update_sprite() -> void:
	if not is_instance_valid(sprite): return
	if textures_directory == "": return
	sprite.flip_h = platform_type == PlatformType.RIGHT
	match platform_type:
		PlatformType.LEFT:   sprite.texture = load(textures_directory + "/platform-edge.png")
		PlatformType.RIGHT:  sprite.texture = load(textures_directory + "/platform-edge.png")
		PlatformType.MIDDLE: sprite.texture = load(textures_directory + "/platform-tile.png")
		PlatformType.BRIDGE: sprite.texture = load(textures_directory + "/platform-bridge.png")
	
	_random_region_texture() 

func _update_collider() -> void:
	if not is_instance_valid(collider): return
	set_collision_layer_value(1, true)
	set_collision_layer_value(10, true)
	collision_mask = collision_layer
#	set_collision_layer_value(10, not platform_type == PlatformType.BRIDGE)
#	set_collision_mask_value(10, not platform_type == PlatformType.BRIDGE)
	collider.one_way_collision = platform_type == PlatformType.BRIDGE
	
func _random_region_texture() -> void:
	if sprite.texture:
		var num_tiles = floor(sprite.texture.get_width()) / int(sprite.region_rect.size.x)
		var skips : int = randi() % num_tiles
		sprite.region_rect.position.x = skips * sprite.region_rect.size.x

func _ready() -> void:
	call_deferred("_update_collider")
	if Engine.is_editor_hint():
		call_deferred("_update_sprite")
