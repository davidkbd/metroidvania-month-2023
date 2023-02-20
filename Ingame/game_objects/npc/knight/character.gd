extends CharacterAlive

@onready var initial_position : Vector2 = global_position
@onready var animation        : AnimationPlayer = $AnimationPlayer
@onready var sword_collider   : CollisionShape2D = $SwordCollider

@onready var player           : Player = null

var walk_direction : float
var value : int = 0

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction
	print("Estaria bien mover este if a un script en el sprite")
	if walk_direction > .0:
		sprite.flip_h = true
	elif walk_direction < .0:
		sprite.flip_h = false 
	sword_collider.position = Vector2.LEFT * (-32.0) * walk_direction + Vector2.UP * 64.0

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
	call_deferred("_update_room_data")
