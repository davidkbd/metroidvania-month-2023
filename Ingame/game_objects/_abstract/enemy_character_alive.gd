extends CharacterAlive
class_name EnemyCharacterAlive

@export_group("Data")
@export var is_storeable : bool = false
@export_group("Life")
@export var reborn_delay_seconds : float = 60.0
@export_range(10.0, 500.0) var max_life : float = 100.0

@onready var initial_position : Vector2 = global_position
@onready var player           : Player = null

@onready var life : float = max_life

var collision_areas : Array[Area2D] = []
var walk_direction  : float

var reborn_timestamp : float = -1.0

func hit(_position : Vector2, _power : float) -> void:
	velocity.x = (global_position.x - _position.x) * _power * .5
	velocity.y = -1 * _power * 15.0
	life -= _power
	_enable_hit_collisions(false)
	if life > 0:
		await create_tween().tween_interval(.2).finished
		_enable_hit_collisions(true)

func update_room_data(_data : Dictionary) -> void:
	if _data.size() == 0 or not _data.has("reborn_timestamp"):
		reborn_timestamp = -1.0
	else:
		reborn_timestamp = _data.reborn_timestamp
	call_deferred("_update_room_data")

func set_died() -> void:
	reborn_timestamp = Time.get_unix_time_from_system() + reborn_delay_seconds
	call_deferred("_update_room_data")

func _enable_hit_collisions(_enabled : bool) -> void:
	for collision in collision_areas:
		collision.collision_layer = 8 if _enabled else 0

func _update_room_data() -> void:
	get_parent().update_instance_data({ "storeable": is_storeable, "reborn_timestamp": reborn_timestamp })
