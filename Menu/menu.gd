extends Node

@export var principal_menu_template     : PackedScene
@export var slots_menu_template         : PackedScene
@export var options_menu_template       : PackedScene
@export var help_menu_template          : PackedScene
@export var credits_menu_template       : PackedScene
@export var game_finished_menu_template : PackedScene

var menu_instance

func hud_listener_on_level_closed() -> void:
	_show_menu(slots_menu_template)

func menu_listener_on_open_principal_menu_pressed() -> void:
	_show_menu(principal_menu_template)

func menu_listener_on_open_slots_menu_pressed() -> void:
	_show_menu(slots_menu_template)

func menu_listener_on_open_options_menu_pressed() -> void:
	_show_menu(options_menu_template)

func menu_listener_on_open_help_menu_pressed() -> void:
	_show_menu(help_menu_template)

func menu_listener_on_open_credits_menu_pressed() -> void:
	_show_menu(credits_menu_template)

func hud_listener_on_game_finished() -> void:
	_show_menu(game_finished_menu_template)

func menu_listener_on_game_start_requested(_level_name : String) -> void:
	menu_instance.queue_free()

func _show_menu(template : PackedScene) -> void:
	if is_instance_valid(menu_instance): menu_instance.queue_free()
	menu_instance = template.instantiate()
	add_child(menu_instance)

func _ready() -> void:
	_show_menu(principal_menu_template)
