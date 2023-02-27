extends Area2D

@onready var player : Player = get_parent()

func _on_area_entered(area : Area2D):
	var power = player.specs.basic_attack_power
	area.hit(global_position, power)
	player.hitenemy_sfx.play()
	var diff = area.global_position.x - player.global_position.x
	player.velocity.x = -player.specs.basic_attack_feedback_impulse * sign(diff)
	player.hitted_enemy = area.get_parent()

