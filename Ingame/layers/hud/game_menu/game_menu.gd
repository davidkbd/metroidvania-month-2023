extends Control

@export var main_game_template : PackedScene
@export var options_template : PackedScene

var main_game_instance : Control
var options_instance : Control

func menu_listener_on_continue_pressed() -> void:
	visible = false
	get_tree().get_first_node_in_group("GAME_LAYER").process_mode = Node.PROCESS_MODE_INHERIT

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
	queue_free()

func _open() -> void:
	visible = true
	get_tree().get_first_node_in_group("GAME_LAYER").process_mode = Node.PROCESS_MODE_DISABLED
	if main_game_instance: main_game_instance.queue_free()
	main_game_instance = main_game_template.instantiate()
	add_child(main_game_instance)

func _process(_delta : float):
	if visible: return
	if Input.is_action_just_pressed("st"):
		_open()

func _ready() -> void:
	hide()
