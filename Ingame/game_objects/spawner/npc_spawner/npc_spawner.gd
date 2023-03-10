@tool
@icon("res://Ingame/game_objects/spawner/npc_spawner/icon.png")
extends Node2D
class_name NpcSpawner

enum NpcType {
	SLIME_01,
	SLIME_02,
	SLIME_03,
	SLIME_04,
	SLIME_05,
	SLIME_06,
	SLIME_07,
	SLIME_08,
	SLIME_09
}

@export var storeable  : bool = true
@export var npc_type : NpcType = NpcType.SLIME_01 :
	get: return npc_type
	set(value):
		if value == npc_type: return
		npc_type = value
		_update_npc_type()

const SPRITES_PATH      := "res://Ingame/game_objects/npc/%s/sprites/spawner_sprite.png"
const PACKEDSCENES_PATH := "res://Ingame/game_objects/npc/%s/character.tscn"
const NPC_DATA := [
	{
		"id": "slime_01"
#		"storeable": true
	},
	{
		"id": "slime_02"
#		"storeable": true
	},
	{
		"id": "slime_03"
#		"storeable": true
	},
	{
		"id": "slime_04"
#		"storeable": true
	},
	{
		"id": "slime_05"
#		"storeable": true
	},
	{
		"id": "slime_06"
#		"storeable": true
	},
	{
		"id": "slime_07"
#		"storeable": true
	},
	{
		"id": "slime_08"
#		"storeable": true
	},
	{
		"id": "slime_09"
#		"storeable": true
	}
	
]

var instance_data : Dictionary = {
	"storeable": storeable,
	"data": {}
}
var instance : Node2D
var instance_name : String

func update_instance_data(_data : Dictionary) -> void:
	instance_data[instance_name.to_lower()] = _data

func activate(_data : Dictionary) -> void:
	if _data.size() > 0 and _data.has("data"):
		instance_data.data = _data.data
	
	instance = load(PACKEDSCENES_PATH % NPC_DATA[npc_type].id).instantiate()
	instance_name = instance.name.to_lower()
	call_deferred("add_child", instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		instance_data.data = instance.data
		instance.queue_free()

func get_state() -> Dictionary:
	return instance_data

func _get_instance_data_from_data(_data : Dictionary) -> Dictionary:
	if _data.has(instance_name): return _data[instance_name]
	return {}

func _update_npc_type() -> void:
	if Engine.is_editor_hint():
		$sprite.texture = load(SPRITES_PATH % NPC_DATA[npc_type].id)

func _ready() -> void:
	instance_data.storeable = storeable

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_npc_type()
	else:
		find_child("sprite").queue_free()
