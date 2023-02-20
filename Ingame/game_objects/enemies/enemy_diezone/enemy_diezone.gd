extends Area2D

func _on_body_entered(body : Beetle):
	if body.is_on_floor():
		body.mark_to_delete()
