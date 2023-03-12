extends Node2D

func _on_body_entered(body):
	if body is CharacterBody2D:
		if body.has_method("entered_in_death_area"):
			body.entered_in_death_area()
		else:
			body.queue_free()
