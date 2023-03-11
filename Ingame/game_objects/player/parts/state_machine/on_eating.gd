extends StateMachineState

@export var eat_timer : float = 1.0

var eat_time    : float
var eat_success : bool

var eating_enemy : EnemyCharacterAlive

func enter() -> void:
	host.velocity = Vector2.ZERO
	eat_success = false
	eat_time = eat_timer
	if is_instance_valid(host.eating_enemy):
		eating_enemy = host.eating_enemy
		host.eating_enemy.eat_health()

func exit() -> void:
#	if eat_success:
#		host.life.increment_value(1.0)
	pass

func step(delta : float) -> StateMachineState:
	if not is_instance_valid(eating_enemy): return state_machine.on_ground

	eat_time -= delta
	
	host.life.increment_value(delta)
	
	if eat_time < .0:
		eat_success = true
		return state_machine.on_ground
	if host.damager.size(): return state_machine.on_damaged
	if ControlInput.get_horizontal_axis(): return state_machine.on_ground
	if ControlInput.is_jump_just_pressed(): return state_machine.on_jump
	if ControlInput.is_attack_just_pressed(): return state_machine.on_attack
	return self
