extends Area2D

func _on_area_entered(_area : Area2D):
	var body = _area.get_parent()
	if body is NPC:
		get_parent().talking_npc = body
		get_parent().talking_npc.show_talk_letter()
	elif body is EnemyCharacterAlive:
		get_parent().eating_enemy = body

func _on_area_exited(_area):
	var body = _area.get_parent()
	if body is NPC:
		if is_instance_valid(get_parent().talking_npc):
			get_parent().talking_npc.hide_talk_letter()
		get_parent().talking_npc = null
	elif body is EnemyCharacterAlive:
		get_parent().eating_enemy = null
