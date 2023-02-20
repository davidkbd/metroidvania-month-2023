extends Area2D

@onready var timer : Timer = $temporarily_deactivate_timer
@onready var enabled : bool = false

var savepoint : SavepointArea = null

func temporarily_deactivate() -> void:
	timer.start(1.0)
	enabled = false

func _on_area_entered(area : SavepointArea):
	if enabled:
		get_tree().get_first_node_in_group("HELP_TIPS").show_pad(0)
		savepoint = area

func _on_area_exited(area : SavepointArea):
	get_tree().get_first_node_in_group("HELP_TIPS").hide_pad()
	savepoint = null

func _physics_process(_delta : float) -> void:
	if savepoint and Input.is_action_just_pressed("u"):
		get_tree().get_first_node_in_group("HELP_TIPS").hide_pad()
		savepoint.activate()
		savepoint = null

func _on_temporarily_deactivate_timer_timeout():
	enabled = true

