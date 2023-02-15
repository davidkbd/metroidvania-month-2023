extends StaticBody2D

func level_listener_on_ready(level_data : Dictionary) -> void:
	if level_data.has("skin"):
		$sprite.texture = load(level_data.skin.textures_directory + "/bottom-platform.png")
