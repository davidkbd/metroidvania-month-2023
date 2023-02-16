extends Area2D

@onready var hook : Node2D = $hook

@onready var camera : FollowTargetCamera = get_tree().get_first_node_in_group("CAMERA")

func enable():
	camera.request(hook)
	hook.enable(get_tree().get_first_node_in_group("PLAYER"))
	
func disable():
	if camera.unrequest(hook):
		hook.disable()

func _ready():
	call_deferred("configure_hook")

func configure_hook():
	var col: CollisionShape2D = get_node("CollisionShape2D")
	var rect = col.shape.get_rect()
	rect.size.x -= get_viewport().size.x
	rect.size.y -= get_viewport().size.y
	rect.position.x += rect.size.x / 2
	rect.position.y += rect.size.y / 2
	rect.position += global_position
	hook.set_rect(rect)
