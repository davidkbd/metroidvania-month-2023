extends Area2D

func _on_area_entered(area : Area2D):
	get_parent().talking_npc = area.get_parent()

func _on_area_exited(area):
	get_parent().talking_npc = null
