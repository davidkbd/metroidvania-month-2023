extends StateMachineState

var onwall_collider_initial_position : Vector2

var walled_time
var intial_direction
var direction

func enter() -> void:
	host.animation_playblack.travel(name)
	intial_direction = host.walk_direction
	_apply_sprite_fip(intial_direction)
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
	
	if ControlInput.is_jump_just_pressed() and direction != intial_direction and direction != .0:
		_apply_impulse(direction)
		return state_machine.on_jump
	if host.is_on_floor(): return state_machine.on_ground
	if not _is_on_wall(): return state_machine.on_air
	if host.damager.size(): return state_machine.on_damaged
	return self

func _update_direction() -> void:
	direction = ControlInput.get_horizontal_axis()

func _walled_gravity(delta) -> void:
	if walled_time < .0:
		host.wall_fall(delta)
		
func _apply_impulse(_direction : float) -> void:
	_apply_sprite_fip(_direction)
	host.velocity.x = direction * host.specs.wall_jump_impulse

func _apply_sprite_fip(_direction : float) -> void:
	if _direction > .0:
		host.sprite.flip_h = true
	elif _direction < .0:
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

func _is_on_wall() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	var origin : Vector2 = host.global_position + host.check_snap_wall_ray_position
	query.from = origin
	query.to = origin + host.check_snap_wall_ray_vector * Vector2.LEFT * sign(host.walk_direction)
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	query.exclude = [host.get_rid()]
	var result = host.space_state.intersect_ray(query)
	return result.size() > 0

func _ready() -> void:
	call_deferred("_update_host_references")
