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
	set_physics_process(true)

func hide_map() -> void:
	if container_visivility_tween: container_visivility_tween.kill()
	container_visivility_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	container_visivility_tween.tween_property(container, "modulate:a", .0, show_time)
	set_physics_process(false)

func toggle_map() -> void:
	if container.modulate.a < 1.0:
		show_map()
	else:
		hide_map()

func _physics_process(_delta : float):
	var player = get_tree().get_first_node_in_group("PLAYER")
	$map_container/map_sprite.position.x = -player.global_position.x * .01
	$map_container/map_sprite.position.y = player.global_position.y * .01

func _ready() -> void:
	container.modulate.a = .0
	set_physics_process(false)
