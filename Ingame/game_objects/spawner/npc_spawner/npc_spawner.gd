@tool
extends Node2D
class_name NpcSpawner

enum NpcType {
	MAGE
}

@export var npc_type : NpcType = NpcType.MAGE :
	get: return npc_type
	set(value):
		if value == npc_type: return
		npc_type = value
		_update_npc_type()

const SPRITES_PATH      := "res://Ingame/game_objects/npc/%s/sprites/spawner_sprite.png"
const PACKEDSCENES_PATH := "res://Ingame/game_objects/npc/%s/character.tscn"
const NPC_DATA := [
	{
		"id": "mage"
#		"storeable": true
	}
]

# Es responsabilidad del npc actualizar esta variable por medio de la funcion
# update_instance_data.
var instance_data : Dictionary = {}
var instance : Node2D
var instance_name : String

func update_instance_data(_data : Dictionary) -> void:
	instance_data[instance_name.to_lower()] = _data
#
#func is_storeable() -> void:
#	return NPC_DATA[npc_type].storeable

func activate(_data : Dictionary) -> void:
	instance = load(PACKEDSCENES_PATH % NPC_DATA[npc_type].id).instantiate()
	instance_name = instance.name.to_lower()
	call_deferred("add_child", instance)
	instance.update_room_data(_get_instance_data_from_data(_data))

func deactivate() -> void:
	if is_instance_valid(instance): instance.queue_free()

func _get_instance_data_from_data(_data : Dictionary) -> Dictionary:
	if _data.has(instance_name): return _data[instance_name]
	return {}

func _update_npc_type() -> void:
	if Engine.is_editor_hint():
		$sprite.texture = load(SPRITES_PATH % NPC_DATA[npc_type].id)

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_npc_type()
	else:
		find_child("sprite").queue_free()
