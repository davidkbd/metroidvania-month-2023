extends Node

class_name Ingame

@export var hud_template          : PackedScene
@export var game_layer_template   : PackedScene
@export var finish_layer_template : PackedScene

var hud_instance
var game_layer_instance
var finish_layer_instance
var failed_layer_instance

var current_level_name

func hud_listener_on_level_closed() -> void:
	if is_instance_valid(hud_instance): hud_instance.queue_free()
	if is_instance_valid(game_layer_instance): game_layer_instance.queue_free()
	if is_instance_valid(finish_layer_instance): finish_layer_instance.queue_free()
	if is_instance_valid(failed_layer_instance): failed_layer_instance.queue_free()

func hud_listener_on_level_restarted() -> void:
	await get_tree().create_timer(1.0).timeout
	hud_listener_on_level_closed()
	menu_listener_on_level_opened(current_level_name)

func hud_listener_on_level_passed() -> void:
	await get_tree().create_timer(1.0).timeout
	hud_listener_on_level_closed()
	var current_level = Levels.find_level(current_level_name)
	menu_listener_on_level_opened(current_level.next.name)

func hud_listener_on_game_finished() -> void:
	await get_tree().create_timer(1.0).timeout
	hud_listener_on_level_closed()

func hud_listener_on_level_finished() -> void:
	finish_layer_instance = finish_layer_template.instantiate()
	add_child(finish_layer_instance)

func menu_listener_on_level_opened(level_name) -> void:
	await get_tree().create_timer(1).timeout
	
	current_level_name = level_name
	
	hud_instance = hud_template.instantiate()
	game_layer_instance = game_layer_template.instantiate()
	
	add_child(hud_instance)
	add_child(game_layer_instance)
	
	game_layer_instance.load_level(level_name)
