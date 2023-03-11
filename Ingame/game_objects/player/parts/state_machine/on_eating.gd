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
	if eat_success:
		host.life.increment_value(1.0)

func step(delta : float) -> StateMachineState:
	if not is_instance_valid(eating_enemy): return state_machine.on_ground

	eat_time -= delta
	
	if eat_time < .0:
		eat_success = true
		return state_machine.on_ground

	return self
