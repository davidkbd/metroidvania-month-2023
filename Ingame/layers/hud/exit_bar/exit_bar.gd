extends Control

@export var duration : float = 3.0

@onready var timebar : ColorRect = $timebar

var bar_tween : Tween

func hud_listener_on_level_finished() -> void:
	queue_free()

func _start_bar() -> void:
	if bar_tween:
		bar_tween.kill()
	timebar.show()
	bar_tween = get_tree().create_tween().bind_node(self)
	bar_tween.tween_property(timebar, "anchor_right", 1, duration)
	await bar_tween.finished
	get_tree().call_group("HUD_LISTENER", "hud_listener_on_level_closed")

func _stop_bar() -> void:
	if bar_tween:
		bar_tween.kill()
	bar_tween = get_tree().create_tween().bind_node(self)
	bar_tween.tween_property(timebar, "anchor_right", .0, .2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await bar_tween.finished
	bar_tween.kill()
	bar_tween = null
	timebar.hide()

func _physics_process(_delta : float):
	if Input.is_action_just_pressed("x"):
		_start_bar()
	elif Input.is_action_just_released("x"):
		_stop_bar()

func _ready() -> void:
	timebar.hide()
	timebar.anchor_right = .0
