extends StateMachineState

@export var eating_amount : float = .02
@export var eating_delay  : float = .5

@onready var beetle : Beetle = get_parent().get_parent()

var eating_timer

func enter() -> void:
	beetle.eating_sfx.play()
	eating_timer = eating_delay

func exit() -> void:
	beetle.eating_sfx.stop()

func step(delta : float) -> StateMachineState:
	if beetle.is_marked_to_die: return get_parent().on_died

	if eating_timer <= .0:
		eating_timer = eating_delay
		_eat()
	else:
		eating_timer -= delta
	
	return self

func _eat() -> void:
	if beetle.plant:
		beetle.plant.beetle_eating(eating_amount)
