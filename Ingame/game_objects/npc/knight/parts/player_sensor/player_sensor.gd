extends Area2D


func _on_body_entered(body):
	get_parent().player = body

func _on_body_exited(body):
	get_parent().player = null
