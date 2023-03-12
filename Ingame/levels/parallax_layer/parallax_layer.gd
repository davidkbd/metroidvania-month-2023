extends ParallaxLayer

@export var parallax_name : String

func room_listener_on_activated(room : Room) -> void:
	if room.parallax_name == "": 
		_show(false)
	else:
		_show(parallax_name == room.parallax_name)

func _show(_visible : bool) -> void:
	visible = _visible
	for child in get_children():
		if child is CPUParticles2D or child is GPUParticles2D:
			child.emitting = _visible
