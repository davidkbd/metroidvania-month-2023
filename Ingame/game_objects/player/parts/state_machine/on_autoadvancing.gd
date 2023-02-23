extends StateMachineState

var speed     : float
var vector    : Vector2
var area_position : Vector2
var position  : Vector2
var direction : AutoadvanceArea.Direction
var is_horizontal : bool

func enter() -> void:
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
	_movement(delta)
	if is_horizontal:
		host.fall(delta)

	host.move_and_slide()
	
	if host.is_on_floor():
		host.animation_playblack.travel("on_ground")

	if is_horizontal:
		if abs(host.global_position.x - position.x) < 5.0:
			return state_machine.on_ground
	else:
		if abs(host.global_position.y - area_position.y) < 5.0:
			host.global_position.x = area_position.x
		if abs(host.global_position.y - position.y) < 5.0:
			if direction == AutoadvanceArea.Direction.UP:
				host.velocity.y = host.specs.jump_impulse
				host.velocity.x = host.specs.jump_impulse * 1.3
				return state_machine.on_air
			return state_machine.on_ground
	return self

func _movement(_delta : float) -> void:
	if is_horizontal:
		host.velocity.x = move_toward(host.velocity.x, vector.x * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = move_toward(host.velocity.x, vector.x, host.specs.acceleration)
		host.velocity.y = move_toward(host.velocity.y, vector.y * host.specs.speed, host.specs.acceleration)
