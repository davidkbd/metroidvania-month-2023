extends StateMachineState

@export var attack_timer : float = .4

var attack_time : float

func enter() -> void:
	host.animation_playblack.travel(name)
	_enable_collision(true)
	attack_time = attack_timer
	host.enemy_hit_area.scale.x = -1 if host.sprite.flip_h else 1

func exit() -> void:
	_enable_collision(false)

func step(delta : float) -> StateMachineState:
	_brake()
	host.fall(delta)
	host.move_and_slide()
	
	attack_time -= delta
	if attack_time < .0: return state_machine.on_ground
	return self

func _enable_collision(_enabled : bool) -> void:
	host.enemy_hit_area.collision_mask = 8 if _enabled else 0

func _brake() -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.attack_deceleration)
