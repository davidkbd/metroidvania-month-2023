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

const SPRITES_PATH := "res://Ingame/game_objects/npc/%s/sprites/spawner_sprite.png"
const NPC_DATA := [
	{
		"id": "mother",
		"update_room_state": true,
		"update_game_state": true
	},
	{
		"id": "grandfa",
		"update_room_state": true,
		"update_game_state": true
	}
]

func _update_npc_type() -> void:
	if Engine.is_editor_hint():
		$sprite.texture = load(SPRITES_PATH % NPC_DATA[npc_type].id)

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_npc_type()
	else:
		find_child("sprite").queue_free()
