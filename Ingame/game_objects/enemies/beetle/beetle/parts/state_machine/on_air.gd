extends StateMachineState

@onready var beetle : Beetle = get_parent().get_parent()

func enter() -> void:
	pass

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	_fall(delta)
	
	beetle.move_and_slide()

	if beetle.velocity.x > .0:
		beetle.sprite.flip_h = true
	elif beetle.velocity.x < .0:
		beetle.sprite.flip_h = false
		
	if beetle.is_on_floor(): return get_parent().on_ground
	if beetle.is_marked_to_die: return get_parent().on_died
	return self

func _fall(delta : float) -> void:
	beetle.fall(delta)
	beetle.velocity.x = move_toward(beetle.velocity.x, .0, beetle.AIR_DECELERATION)
