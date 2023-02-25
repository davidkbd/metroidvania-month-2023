extends ParallaxLayer

func room_listener_on_activated(room : Room) -> void:
	if room.parallax_name == "": return
	visible = name.begins_with(room.parallax_name)
	for child in get_children():
		if child is CPUParticles2D or child is GPUParticles2D:
			child.emitting = visible
