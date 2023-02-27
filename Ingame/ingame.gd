extends Node

class_name Ingame

@export var hud_template          : PackedScene
@export var map_template          : PackedScene
@export var game_layer_template   : PackedScene

var hud_instance
var map_instance
var game_layer_instance

var current_level_name

func hud_listener_on_level_closed() -> void:
	if is_instance_valid(hud_instance): hud_instance.queue_free()
	if is_instance_valid(map_instance): map_instance.queue_free()
	if is_instance_valid(game_layer_instance): game_layer_instance.queue_free()

func hud_listener_on_game_finished() -> void:
	await get_tree().create_timer(1.0).timeout
	hud_listener_on_level_closed()

func progress_listener_on_game_state_loaded(_game_state : Dictionary) -> void:
	await get_tree().create_timer(1).timeout
	
	current_level_name = _game_state.level.level

	hud_instance = hud_template.instantiate()
	map_instance = map_template.instantiate()
	game_layer_instance = game_layer_template.instantiate()

	add_child(map_instance)
	add_child(hud_instance)
	add_child(game_layer_instance)
	game_layer_instance.instance_level(_game_state)
	map_instance.initialize(_game_state)

func progress_listener_on_player_died_game_state_loaded(_game_state : Dictionary) -> void:
	game_layer_instance.reset_level(_game_state)
	map_instance.initialize(_game_state)
