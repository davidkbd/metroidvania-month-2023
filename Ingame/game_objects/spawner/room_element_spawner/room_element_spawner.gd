@tool
@icon("res://Ingame/game_objects/spawner/room_element_spawner/icon.png")
extends Node2D
class_name RoomElementSpawner

enum ElementType {
	RAT_HEALTH, RAT_HEALTH_HOME
}

@export var element_type : ElementType = ElementType.RAT_HEALTH :
	get: return element_type
	set(value):
		if value == element_type: return
		element_type = value
		_update_element_type()

const SPRITES_PATH      := "res://Ingame/game_objects/room/%s/sprites/spawner_sprite.png"
const PACKEDSCENES_PATH := "res://Ingame/game_objects/room/%s/%s.tscn"
const TYPE_DATA := [
	{
		"id": "rat_health_home"
	},
	{
		"id": "empty_rat_health_home"
	}

]

var instance_data : Dictionary = {
	"storeable": false
}
var instance : Node2D
var instance_name : String

func update_instance_data(_data : Dictionary) -> void:
	instance_data[instance_name.to_lower()] = _data

func activate(_data : Dictionary) -> void:
	instance = load(PACKEDSCENES_PATH % [TYPE_DATA[element_type].id, TYPE_DATA[element_type].id]).instantiate()
	instance_name = instance.name.to_lower()
	call_deferred("add_child", instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		instance.queue_free()

func get_state() -> Dictionary:
	return instance_data

func _update_element_type() -> void:
	if Engine.is_editor_hint():
		print(SPRITES_PATH % TYPE_DATA[element_type].id)
		$sprite.texture = load(SPRITES_PATH % TYPE_DATA[element_type].id)

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_element_type()
	else:
		find_child("sprite").queue_free()
