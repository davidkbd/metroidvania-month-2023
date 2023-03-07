@tool
@icon("res://Ingame/game_objects/spawner/item_spawner/icon.png")
extends Node2D
class_name ItemSpawner

enum ElementType {
	RAT_HEALTH
}

@export var reborn_delay_seconds : float = 300.0
@export var element_type : ElementType = ElementType.RAT_HEALTH :
	get: return element_type
	set(value):
		if value == element_type: return
		element_type = value
		_update_element_type()

const SPRITES_PATH      := "res://Ingame/game_objects/items/%s/sprites/spawner_sprite.png"
const PACKEDSCENES_PATH := "res://Ingame/game_objects/items/%s/%s.tscn"
const TYPE_DATA := [
	{
		"id": "rat_health"
	}
]

var instance_data : Dictionary = {
	"storeable": false,
	"reborn_timestamp": -1
}
var instance : Node2D
var instance_name : String
var player_is_died : bool

func player_listener_on_died() -> void:
	player_is_died = true

func update_instance_data(_data : Dictionary) -> void:
	instance_data[instance_name.to_lower()] = _data

func activate(_data : Dictionary) -> void:
	player_is_died = false
	if _data.size() == 0 or not _data.has("reborn_timestamp"):
		instance_data.reborn_timestamp = -1.0
	else:
		instance_data.reborn_timestamp = _data.reborn_timestamp

	if instance_data.reborn_timestamp > Time.get_unix_time_from_system():
		return

	instance = load(PACKEDSCENES_PATH % [TYPE_DATA[element_type].id, TYPE_DATA[element_type].id]).instantiate()
	instance_name = instance.name.to_lower()
	call_deferred("add_child", instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		if instance is DestroyableObject:
			if player_is_died:
				instance_data.reborn_timestamp = -1.0
			elif instance.catched:
				instance_data.reborn_timestamp = Time.get_unix_time_from_system() + reborn_delay_seconds
		else:
			if player_is_died:
				instance_data.reborn_timestamp = -1.0
			elif instance.catched:
				instance_data.reborn_timestamp = Time.get_unix_time_from_system() + reborn_delay_seconds
		instance.queue_free()

func get_state() -> Dictionary:
	return instance_data

func _update_element_type() -> void:
	if Engine.is_editor_hint():
		$sprite.texture = load(SPRITES_PATH % TYPE_DATA[element_type].id)

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_element_type()
	else:
		find_child("sprite").queue_free()
