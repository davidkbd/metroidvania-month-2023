extends Control

func _ready() -> void:
	$play_button.grab_focus()
	$background/moco.play()

