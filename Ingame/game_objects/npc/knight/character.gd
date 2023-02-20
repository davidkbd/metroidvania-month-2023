extends CharacterAlive

var value : int = 0

@onready var player           : Player = null

@onready var initial_position : Vector2 = global_position
@onready var animation        : AnimationPlayer = $AnimationPlayer
@onready var sword_collider   : CollisionShape2D = $SwordCollider

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
	
func flip(direction):
	sprite.flip_h = direction > 0
	sword_collider.position = Vector2.LEFT * (-32.0) * direction + Vector2.UP * 64.0

func _ready() -> void:
	call_deferred("_update_room_data")
