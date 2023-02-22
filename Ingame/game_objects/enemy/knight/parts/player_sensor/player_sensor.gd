extends Area2D


func _on_body_entered(_body : Player):
	get_parent().player = _body

func _on_body_exited(_body : Player):
	get_parent().player = null
