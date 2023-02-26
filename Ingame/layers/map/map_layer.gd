extends CanvasLayer
class_name Map

signal closed

@export var show_time : float = .25
@export var hide_time : float = .5

@onready var container : Control = $map_container

var container_visivility_tween : Tween

func progress_listener_on_progress_stored(_game_state : Dictionary) -> void:
	initialize(_game_state)

func show_map() -> void:
	get_tree().paused = true
	container.open()
	if container_visivility_tween: container_visivility_tween.kill()
	container_visivility_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	container_visivility_tween.tween_property(container, "modulate:a", 1.0, show_time)
	container.scroll.position = Vector2.ZERO

func hide_map() -> void:
	get_tree().paused = false
	if container_visivility_tween: container_visivility_tween.kill()
	container_visivility_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	container_visivility_tween.tween_property(container, "modulate:a", .0, hide_time)
	await container_visivility_tween.finished
	container.hide()

func initialize(_game_state : Dictionary) -> void:
	if _game_state.has("rooms"):
		container.initialize_rooms_state(_game_state.rooms)
	if _game_state.has("map"):
		container.initialize_map_state(_game_state.map)

func _process(_delta : float) -> void:
	if ControlInput.is_map_just_pressed():
		if container.modulate.a > .1:
			hide_map()
		else:
			show_map()

func _ready() -> void:
	container.modulate.a = .0
	container.hide()
