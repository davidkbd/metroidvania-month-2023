extends StateMachineState

@export var check_floor_ray_vector : Vector2 = Vector2.DOWN * 32.0
@export var coyote_time : float = .08

@onready var player : Player = get_parent().get_parent()
@onready var space_state = player.get_world_2d().get_direct_space_state()

var coyote_timer : float

func enter() -> void:
	player.cube_can_fill = true
	coyote_timer = coyote_time

func exit() -> void:
	player.cube_can_fill = false

		
func step(delta : float) -> StateMachineState:
	_coyote_time(delta)
	_movement()

	if player.velocity.x > .0:
		player.sprite.flip_h = true
	elif player.velocity.x < .0:
		player.sprite.flip_h = false

	player.move_and_slide()

	if Input.is_action_just_pressed("j"): return get_parent().on_jump
	if Input.is_action_pressed("d"): return get_parent().on_crouch
	if coyote_timer < .0: return get_parent().on_air
	if player.damager: return get_parent().on_damaged
	
	return self

func _coyote_time(delta : float) -> void:
	if player.is_on_floor():
		coyote_timer = coyote_time
	else:
		player.fall(delta)
		coyote_timer -= delta

func _movement() -> void:
	var direction = Input.get_axis("l", "r")
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction * player.SPEED, player.ACCELERATION)
	else:
		player.velocity.x = move_toward(player.velocity.x, .0, player.DECELERATION)
