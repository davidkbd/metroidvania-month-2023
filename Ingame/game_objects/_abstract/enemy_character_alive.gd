extends CharacterAlive
class_name EnemyCharacterAlive

signal died

@export_group("Data")
@export var is_storeable : bool = false
@export_group("Life")
@export_range(10.0, 500.0) var max_life : float = 100.0

@onready var initial_position : Vector2 = global_position
@onready var player           : Player = null

@onready var life : float = max_life

var collision_areas : Array[Area2D] = []
var walk_direction  : float

var catched : bool

func hit(_position : Vector2, _power : float) -> void:
	velocity.x = (global_position.x - _position.x) * _power * .5
	velocity.y = -1 * _power * 15.0
	life -= _power
	_enable_hit_collisions(false)
	if life > 0:
		await create_tween().tween_interval(.2).finished
		_enable_hit_collisions(true)

func set_died() -> void:
	var area : Area2D = Area2D.new()
	var collision_shape : CollisionShape2D = CollisionShape2D.new()
	area.add_child(collision_shape)
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = 24.0
	area.monitoring = false
	area.monitorable = true
	area.collision_layer = 256
	area.collision_mask = 0
	area.position = Vector2.ZERO
	add_child(area)
	emit_signal("died")

func _enable_hit_collisions(_enabled : bool) -> void:
	for collision in collision_areas:
		collision.collision_layer = 8 if _enabled else 0

func _enter_tree() -> void:
	add_to_group("ENEMY")

func catch() -> void:
	catched = true
	sprite.hide()
	collision_layer = 0
	collision_mask = 0
	set_process(false)
