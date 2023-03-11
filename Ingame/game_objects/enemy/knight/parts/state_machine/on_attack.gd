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
	print("DEBERIA DE ESCOGERSE ALEATORIAMENTE EL ATACKE DURANTE on_chase CON UN TIMER POR EJEMPLO, ASI CADA ATAQUE PUEDE TENER UN attack_distance DIFERENTE")
	var attack_id : int
	if host.global_position.distance_to(host.player.global_position) < 120:
		attack_id = 1
	else:
		attack_id = randi_range(1, 2)
	match attack_id:
		1:
			attack_deceleration = host.specs.attack1_deceleration
			time = host.animation.get_animation("attack").length
		2:
			attack_deceleration = host.specs.attack2_deceleration
			time = host.animation.get_animation("attack").length
