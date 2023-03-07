extends StateMachineState

var attack_direction : Vector2

func enter() -> void:
	host.animation_playblack.travel("on_attack")
	attack_direction = Vector2.UP
	host.velocity.x = .0
	host.velocity.y = host.specs.drop_attack_impulse
	host.animation_tree.set("parameters/on_attack/blend_position", 0)
	host.animation_tree.set("parameters/on_attack/0/blend_position", attack_direction)
	_enable_collision(true)

func exit() -> void:
	_enable_collision(false)
	if host.hitted_enemy \
	and is_instance_valid(host.hitted_enemy) \
	and attack_direction.y < .0:
		host.velocity.y = -host.specs.basic_attack_down_feedback_impulse
	host.hitted_enemy = null
	host.enemy_hit_area.collider.disabled = true

func step(delta : float) -> StateMachineState:
	host.fall(delta)
	host.move_and_slide()

	if host.deatharea_entered: return state_machine.on_deatharea_entered
	if host.hitted_enemy and is_instance_valid(host.hitted_enemy): return state_machine.on_air
	if host.is_on_floor(): return state_machine.on_ground
	return self

func _enable_collision(_enabled : bool) -> void:
	# 8=enemy + 16384=destroyable
	host.enemy_hit_area.collision_mask = 8 + 16384 if _enabled else 0
