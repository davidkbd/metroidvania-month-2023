extends Control

@export var main_game_template : PackedScene
@export var options_template : PackedScene

var main_game_instance : Control
var options_instance : Control

func menu_listener_on_continue_pressed() -> void:
	AudioServer.set_bus_effect_enabled(2, 1, false)
	visible = false
	get_tree().paused = false

func menu_listener_on_options_pressed() -> void:
	if main_game_instance: main_game_instance.queue_free()
	main_game_instance = null
	if options_instance: options_instance.queue_free()
	options_instance = options_template.instantiate()
	add_child(options_instance)

func menu_listener_on_game_menu_pressed() -> void:
	if options_instance: options_instance.queue_free()
	options_instance = null
	_open()

func hud_listener_on_level_finished() -> void:
	AudioServer.set_bus_effect_enabled(2, 1, false)
	queue_free()

func _open() -> void:
	if get_tree().paused: return
	visible = true
	get_tree().paused = true
	if main_game_instance: main_game_instance.queue_free()
	main_game_instance = main_game_template.instantiate()
	add_child(main_game_instance)
	AudioServer.set_bus_effect_enabled(2, 1, true)

func _process(_delta : float):
	if visible: return
	if ControlInput.is_menu_just_pressed():
		_open()

func _ready() -> void:
	hide()
