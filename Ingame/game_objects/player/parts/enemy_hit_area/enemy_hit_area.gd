extends Area2D

@onready var player : Player = get_parent()

func _on_area_entered(area : Area2D):
	if player.can_hit_enemy():
		player.enemy_died = area.hit()
