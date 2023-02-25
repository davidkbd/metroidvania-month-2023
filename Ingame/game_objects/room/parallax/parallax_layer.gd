extends ParallaxLayer

func room_listener_on_activated(room : Room) -> void:
	if room.parallax_name == "": return
	visible = name == room.parallax_name
