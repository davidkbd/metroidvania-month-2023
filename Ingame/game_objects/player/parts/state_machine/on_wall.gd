extends StateMachineState

var onwall_collider_initial_position : Vector2

var walled_time
var intial_direction
var direction

func enter() -> void:
	intial_direction = sign(host.get_last_slide_collision().get_position().x - host.global_position.x)
	_snap_to_wall(intial_direction)
	walled_time = .15
	direction = .0
	host.velocity = Vector2.ZERO
	_update_colliders()

func exit() -> void:
	_restore_colliders()

func step(delta : float) -> StateMachineState:
	_update_direction()
	_walled_gravity(delta)
	host.move_and_slide()
	walled_time -= delta
	if Input.is_action_just_pressed("j") and direction != intial_direction and direction != .0:
		_apply_impulse(direction)
		return state_machine.on_jump
	if host.is_on_floor(): return state_machine.on_ground
	if host.enemy_died: return state_machine.on_enemybounce
	if host.damager: return state_machine.on_damaged
	return self

func _update_direction() -> void:
	direction = Input.get_axis("l", "r")

func _walled_gravity(delta) -> void:
	if walled_time < .0:
		host.wall_fall(delta)
		
func _apply_impulse(direction) -> void:
	_snap_to_wall(direction)
	host.velocity.x = direction * host.specs.wall_jump_impulse

func _snap_to_wall(direction) -> void:
	if direction > .0:
		host.sprite.flip_h = true
	elif direction < .0:
		host.sprite.flip_h = false 

func _update_colliders() -> void:
	host.body_collider.disabled = true
	host.onwall_collider.disabled = false
	host.onwall_collider.position.x = onwall_collider_initial_position.x * sign(-host.walk_direction)

func _restore_colliders() -> void:
	host.body_collider.disabled = false
	host.onwall_collider.disabled = true

func _update_host_references() -> void:
	onwall_collider_initial_position = host.onwall_collider.position

func _ready() -> void:
	call_deferred("_update_host_references")
