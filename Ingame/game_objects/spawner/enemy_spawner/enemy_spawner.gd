@tool
extends Node2D
class_name EnemySpawner

enum EnemyType {
	KNIGHT
}

@export var enemy_type : EnemyType = EnemyType.KNIGHT :
	get: return enemy_type
	set(value):
		if value == enemy_type: return
		enemy_type = value
		_update_enemy_type()

const SPRITES_PATH      := "res://Ingame/game_objects/enemy/%s/sprites/spawner_sprite.png"
const PACKEDSCENES_PATH := "res://Ingame/game_objects/enemy/%s/character.tscn"
const NPC_DATA := [
	{
		"id": "knight"
	}
]

# Es responsabilidad del npc actualizar esta variable por medio de la funcion
# update_instance_data.
var instance_data : Dictionary = {}
var instance : Node2D
var instance_name : String

func update_instance_data(_data : Dictionary) -> void:
	instance_data[instance_name.to_lower()] = _data

func activate(_data : Dictionary) -> void:
	instance = load(PACKEDSCENES_PATH % NPC_DATA[enemy_type].id).instantiate()
	instance_name = instance.name.to_lower()
	call_deferred("add_child", instance)
	instance.update_room_data(_get_instance_data_from_data(_data))

func deactivate() -> void:
	if is_instance_valid(instance): instance.queue_free()

func _get_instance_data_from_data(_data : Dictionary) -> Dictionary:
	if _data.has(instance_name): return _data[instance_name]
	return {}

func _update_enemy_type() -> void:
	if Engine.is_editor_hint():
		$sprite.texture = load(SPRITES_PATH % NPC_DATA[enemy_type].id)

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_enemy_type()
	else:
		find_child("sprite").queue_free()
