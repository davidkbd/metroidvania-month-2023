extends StateMachineState

@export var attack_timer : float = .2

var attack_time : float
var attack_direction : Vector2

func enter() -> void:
	host.animation_playblack.travel("on_attack")
	attack_direction = Vector2(ControlInput.get_horizontal_axis(), -ControlInput.get_vertical_axis())
	if not host.can_attack_down():
		attack_direction.y = clamp(attack_direction.y, .0, 1.0)
	
	host.animation_tree.set("parameters/on_attack/blend_position", 0)
	host.animation_tree.set("parameters/on_attack/0/blend_position", attack_direction)
	_enable_collision(true)
	attack_time = attack_timer
	host.enemy_hit_area.scale.x = -1 if host.sprite.flip_h else 1
	host.enemy_hit_area.collider.disabled = false

func exit() -> void:
	_enable_collision(false)
	if host.hitted_enemy \
	and is_instance_valid(host.hitted_enemy) \
	and attack_direction.y < .0:
		host.velocity.y = -host.specs.basic_attack_down_feedback_impulse
	host.hitted_enemy = null
	host.enemy_hit_area.collider.disabled = true

func step(delta : float) -> StateMachineState:
	_movement()
	host.fall(delta)
	host.move_and_slide()
	
	attack_time -= delta

	if host.deatharea_entered: return state_machine.on_deatharea_entered
	if not state_machine.previous_state.is_an_on_air_state() and ControlInput.is_jump_just_pressed(): return state_machine.on_jump
	if host.hitted_enemy and is_instance_valid(host.hitted_enemy): return state_machine.on_ground
	if attack_time < .0:
		if state_machine.previous_state.is_an_on_air_state():
			return state_machine.on_air
		return state_machine.on_ground
	if ControlInput.is_attack_just_pressed():
		host.animation_playblack.start("on_attack", true)
		enter()
	return self

func _enable_collision(_enabled : bool) -> void:
	# 8=enemy + 16384=destroyable
	host.enemy_hit_area.collision_mask = 8 + 16384 if _enabled else 0

func _movement() -> void:
	host.set_walk_direction(ControlInput.get_horizontal_axis())
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
