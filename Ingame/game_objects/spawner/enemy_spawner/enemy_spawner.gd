@tool
@icon("res://Ingame/game_objects/spawner/enemy_spawner/icon.png")
extends Node2D
class_name EnemySpawner

enum EnemyType {
	KNIGHT
}

@export var reborn_delay_seconds : float = 60.0
@export var storeable  : bool = true
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

var instance_data : Dictionary = {
	"storeable": storeable,
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

	instance = load(PACKEDSCENES_PATH % NPC_DATA[enemy_type].id).instantiate()
	instance_name = instance.name.to_lower()
	call_deferred("add_child", instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		if player_is_died:
			instance_data.reborn_timestamp = -1.0
		elif instance.life <= 0:
			instance_data.reborn_timestamp = Time.get_unix_time_from_system() + reborn_delay_seconds
		instance.queue_free()

func get_state() -> Dictionary:
	return instance_data

func _get_instance_data_from_data(_data : Dictionary) -> Dictionary:
	if _data.has(instance_name): return _data[instance_name]
	return {}

func _update_enemy_type() -> void:
	if Engine.is_editor_hint():
		$sprite.texture = load(SPRITES_PATH % NPC_DATA[enemy_type].id)

func _ready() -> void:
	instance_data.storeable = storeable

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		_update_enemy_type()
	else:
		find_child("sprite").queue_free()
