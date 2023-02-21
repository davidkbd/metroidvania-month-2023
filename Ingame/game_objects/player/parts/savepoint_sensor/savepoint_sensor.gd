extends Area2D

@onready var enabled : bool = false

var savepoint : SavepointArea = null

func room_listener_on_activated(_room : Room) -> void:
	enabled = false
	await create_tween().tween_interval(2.0).finished
	enabled = true

func _on_area_entered(area : SavepointArea):
	if enabled:
		get_tree().get_first_node_in_group("HELP_TIPS").show_pad(0)
		savepoint = area

func _on_area_exited(_area : SavepointArea):
	get_tree().get_first_node_in_group("HELP_TIPS").hide_pad()
	savepoint = null

func _physics_process(_delta : float) -> void:
	if savepoint and Input.is_action_just_pressed("u"):
		get_tree().get_first_node_in_group("HELP_TIPS").hide_pad()
		savepoint.activate()
		savepoint = null
