extends StateMachineState

var speed     : float
var vector    : Vector2
var area_position : Vector2
var position  : Vector2
var direction : AutoadvanceArea.Direction
var is_horizontal : bool
var is_falling    : bool

func enter() -> void:
	is_falling = false
	speed = host.velocity.length()
	direction = host.autoadvance_area.direction
	is_horizontal = (direction == AutoadvanceArea.Direction.LEFT or direction == AutoadvanceArea.Direction.RIGHT)
	match direction:
		AutoadvanceArea.Direction.UP:
			vector = Vector2.UP
		AutoadvanceArea.Direction.RIGHT:
			vector = Vector2.RIGHT
		AutoadvanceArea.Direction.DOWN:
			vector = Vector2.DOWN
		AutoadvanceArea.Direction.LEFT:
			vector = Vector2.LEFT
	area_position = host.autoadvance_area.global_position
	position = host.autoadvance_area.global_position + vector * host.autoadvance_area.distance

func exit() -> void:
	pass

func step(delta : float) -> StateMachineState:
	if not is_falling:
		_movement(delta)
	if is_horizontal or is_falling:
		host.fall(delta)

	host.move_and_slide()
	
	if host.is_on_floor():
		host.animation_playblack.travel("on_ground")

	if is_horizontal:
		if abs(host.global_position.x - position.x) < 5.0:
			return state_machine.on_ground
	else:
		if abs(host.global_position.y - position.y) < 5.0:
			if not is_falling:
				host.velocity.y = host.specs.jump_impulse
				var control_direction = sign(ControlInput.get_horizontal_axis())
				if not control_direction: control_direction = 1.0
				host.velocity.x = 160.0 * control_direction
			is_falling = true
		if not is_falling and abs(host.global_position.y - area_position.y) < 5.0:
			host.global_position.x = area_position.x
	if is_falling and host.is_on_floor():
		return state_machine.on_ground
	return self

func _movement(_delta : float) -> void:
	if is_horizontal:
		host.velocity.x = move_toward(host.velocity.x, vector.x * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, vector.x, host.specs.acceleration)
		host.velocity.y = move_toward(host.velocity.y, vector.y * host.specs.speed, host.specs.acceleration)
