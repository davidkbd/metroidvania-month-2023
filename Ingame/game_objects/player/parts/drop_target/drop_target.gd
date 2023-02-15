extends Area2D

func _on_body_entered(body : Drop) -> void:
	if get_parent().catch_drop():
		body.catch_by_player()
