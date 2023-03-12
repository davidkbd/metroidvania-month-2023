extends CharacterAlive
class_name EnemyCharacterAlive

signal died

@export_group("Data")
@export var is_storeable : bool = false
@export_group("Life")
@export_range(10.0, 500.0) var max_life : float = 100.0
@export_group("Visualization")
@export var damaged_modulate_color : Color = Color(2.5, 2.5, 2.5, 1.0)

@onready var initial_position : Vector2 = global_position
@onready var player           : Player = null

@onready var life : float = max_life

var collision_areas : Array[Area2D] = []
var walk_direction  : float
var eat_health_area : Area2D

var modulate_tween : Tween

func hit(_position : Vector2, _power : float) -> void:
	velocity.x = (global_position.x - _position.x) * _power * specs.damage_feedback_inpulse
	velocity.y = -1 * _power * 4.0
	life -= _power
	if modulate_tween: modulate_tween.kill()
	modulate_tween = create_tween()
	modulate = damaged_modulate_color
	modulate_tween.tween_property(self, "modulate", Color.WHITE, .25)
	_enable_hit_collisions(false)
	if life > 0:
		await create_tween().tween_interval(.2).finished
		_enable_hit_collisions(true)

func eat_health() -> void:
	if eat_health_area and is_instance_valid(eat_health_area):
		eat_health_area.queue_free()
		if modulate_tween: modulate_tween.kill()
		modulate_tween = create_tween()
		modulate_tween.tween_property(self, "modulate:a", .0, 1.0)

func set_died() -> void:
	_create_interact_area()
	set_collision_mask_value(11, true) # colision contra suelo activada
	emit_signal("died")

func _create_interact_area() -> void:
	eat_health_area = Area2D.new()
	var collision_shape : CollisionShape2D = CollisionShape2D.new()
	eat_health_area.add_child(collision_shape)
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = 24.0
	eat_health_area.monitoring = false
	eat_health_area.monitorable = true
	eat_health_area.collision_layer = 32 # interact
	eat_health_area.collision_mask = 0
	eat_health_area.position = Vector2.ZERO
	add_child(eat_health_area)

func _enable_hit_collisions(_enabled : bool) -> void:
	for collision in collision_areas:
		collision.collision_layer = 8 if _enabled else 0

func _enter_tree() -> void:
	add_to_group("ENEMY")

func _ready() -> void:
	$AnimationTree.active = true
