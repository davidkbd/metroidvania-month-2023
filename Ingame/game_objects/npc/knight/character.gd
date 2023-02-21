extends CharacterAlive

@onready var initial_position : Vector2 = global_position
@onready var animation        : AnimationPlayer = $AnimationPlayer
@onready var sword_collider   : CollisionShape2D = $SwordCollider
@onready var center           : Node2D = $Center

@onready var player           : Player = null

var walk_direction : float
var value : int = 0

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction
	sword_collider.position = Vector2.LEFT * (-32.0) * walk_direction + Vector2.UP * 64.0

func attack_impulse() -> void:
	velocity.x = specs.attack_impulse * walk_direction

func update_room_data(_data : Dictionary) -> void:
	print("NPC LOADED DATA: ", _data)
	if _data.size() == 0:
		value = 0
	else:
		value = _data.value
	value += 1
	call_deferred("_update_room_data")

func _update_room_data() -> void:
	get_parent().update_instance_data({ "storeable": true, "value": value })

func _ready() -> void:
	specs = CharacterAliveSpecs.get_knight_specs()
	call_deferred("_update_room_data")
