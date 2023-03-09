@tool
@icon("res://Ingame/game_objects/spawner/npc_spawner/icon.png")
extends Node2D
class_name NpcSpawner

enum NpcType {
	SLIME_01,
	SLIME_02,
	SLIME_03
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
	}
]

var instance_data : Dictionary = {
	"storeable": storeable,
	"step": 0
}
var instance : Node2D
var instance_name : String

func update_instance_data(_data : Dictionary) -> void:
	instance_data[instance_name.to_lower()] = _data

func activate(_data : Dictionary) -> void:
	if _data.size() == 0 or not _data.has("step"):
		instance_data.step = 0
	else:
		instance_data.step = _data.step
	
	instance = load(PACKEDSCENES_PATH % NPC_DATA[npc_type].id).instantiate()
	instance_name = instance.name.to_lower()
	call_deferred("add_child", instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		if instance.pass_step(): instance_data.step += 1
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
