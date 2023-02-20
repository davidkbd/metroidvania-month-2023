extends CanvasLayer
class_name Map

@export var show_time : float = 1.0
@export var hide_time : float = 1.0

@onready var container : Control = $map_container

var container_visivility_tween : Tween

func show_map() -> void:
	if container_visivility_tween: container_visivility_tween.kill()
	container_visivility_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	container_visivility_tween.tween_property(container, "modulate:a", 1.0, show_time)

func hide_map() -> void:
	if container_visivility_tween: container_visivility_tween.kill()
	container_visivility_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	container_visivility_tween.tween_property(container, "modulate:a", .0, show_time)

func toggle_map() -> void:
	if container.modulate.a < 1.0:
		show_map()
	else:
		hide_map()

func _ready() -> void:
	container.modulate.a = .0
