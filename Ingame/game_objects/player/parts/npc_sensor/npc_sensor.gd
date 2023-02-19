extends Area2D

func _on_area_entered(area : Area2D):
	get_parent().talking_npc = area.get_parent()
	get_parent().talking_npc.show_talk_letter()

func _on_area_exited(area):
	if is_instance_valid(get_parent().talking_npc):
		get_parent().talking_npc.hide_talk_letter()
	get_parent().talking_npc = null
