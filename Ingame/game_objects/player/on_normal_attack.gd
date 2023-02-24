extends StateMachineState

@export var attack_timer : float = .2

var attack_time : float

func enter() -> void:
	host.animation_playblack.travel("on_attack")
	host.animation_tree.set("parameters/on_attack/blend_position", .1)
	_enable_collision(true)
	attack_time = attack_timer
	host.enemy_hit_area.scale.x = -1 if host.sprite.flip_h else 1

func exit() -> void:
	_enable_collision(false)

func step(delta : float) -> StateMachineState:
	_movement()
	host.fall(delta)
	host.move_and_slide()
	
	attack_time -= delta
	if attack_time < .0: return state_machine.on_ground
	return self

func _enable_collision(_enabled : bool) -> void:
	host.enemy_hit_area.collision_mask = 8 if _enabled else 0

func _movement() -> void:
	host.set_walk_direction(ControlInput.get_horizontal_axis())
	if host.walk_direction:
		host.velocity.x = move_toward(host.velocity.x, host.walk_direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, .0, host.specs.deceleration)
