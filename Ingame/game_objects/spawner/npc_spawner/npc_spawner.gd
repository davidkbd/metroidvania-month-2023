extends Node2D
class_name NpcSpawner
@tool

enum NpcType {
	MOTHER, GRANDPA
}

@export var npc_type : NpcType = NpcType.MOTHER :
	get: return npc_type
	set(value):
		if value == npc_type: return
		npc_type = value
		_update_npc_type()

const SPRITES_PATH      := "res://Ingame/game_objects/npc/%s/sprites/spawner_sprite.png"
const PACKEDSCENES_PATH := "res://Ingame/game_objects/npc/%s/character.tscn"
const NPC_DATA := [
	{
		"id": "mother",
		"storeable": true
	},
	{
		"id": "grandfa",
		"storeable": true
	}
]

# Es responsabilidad del npc actualizar esta variable por medio de la funcion
# update_instance_data.
var instance_data : Dictionary = {}
var instance : Node2D

func update_instance_data(_data : Dictionary) -> void:
	instance_data[name.to_lower()] = _data

func is_storeable() -> void:
	return NPC_DATA[npc_type].storeable

func activate(_data : Dictionary) -> void:
	instance = load(PACKEDSCENES_PATH % NPC_DATA[npc_type].id).instantiate()
	instance.update_data(_data)
	add_child(instance)

func deactivate() -> void:
	if is_instance_valid(instance): instance.queue_free()

func _update_npc_type() -> void:
	if Engine.is_editor_hint():
		$sprite.texture = load(SPRITES_PATH % NPC_DATA[npc_type].id)

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_npc_type()
	else:
		find_child("sprite").queue_free()
