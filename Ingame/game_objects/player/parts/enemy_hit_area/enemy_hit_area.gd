extends Area2D

@onready var collider : CollisionShape2D = $CollisionShape2D
@onready var player : Player = get_parent()

func _on_area_entered(area : Area2D):
	if area is DestroyableObject:
		_hit_destroyable(area)
	else:
		_hit_enemy(area)

func _hit_enemy(area : Area2D) -> void:
	var power = player.specs.basic_attack_power
	area.hit(global_position, power)
	player.hitenemy_sfx.play()
	var diff = area.global_position.x - player.global_position.x
	player.velocity.x = -player.specs.basic_attack_feedback_impulse * sign(diff)
	player.hitted_enemy = area.get_parent()

func _hit_destroyable(area : Area2D) -> void:
	area.destroy(player)
	var diff = area.global_position.x - player.global_position.x
	player.velocity.x = -player.specs.basic_attack_feedback_impulse * sign(diff)
