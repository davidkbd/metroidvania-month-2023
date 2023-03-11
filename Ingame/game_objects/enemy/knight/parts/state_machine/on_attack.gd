extends StateMachineState

var time : float

var attack_deceleration : float

func enter() -> void:
	host.animation_playblack.start(name, true)
	host.velocity = Vector2.ZERO
	_choose_attack()

func exit() -> void:
	host.sword_collider.disabled = true
	
func step(delta : float) -> StateMachineState:
	_brake()
	host.fall(delta)
	host.move_and_slide()
	
	time -= delta
	
	if host.life <= 0: return state_machine.on_die
	if time <= .0: return state_machine.on_chase
	return self

func _brake() -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, attack_deceleration)

func _choose_attack() -> void:
	match randi_range(1, 2):
		1:
			attack_deceleration = host.specs.attack1_deceleration
			time = host.animation.get_animation("attack").length
		2:
			attack_deceleration = host.specs.attack2_deceleration
			time = host.animation.get_animation("attack").length
