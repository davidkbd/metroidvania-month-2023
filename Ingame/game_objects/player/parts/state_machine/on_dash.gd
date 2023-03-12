extends StateMachineState

@export var check_ceil_ray_position_l : Vector2 = Vector2.UP * 16.0 + Vector2.LEFT * 16.0
@export var check_ceil_ray_position_r : Vector2 = Vector2.UP * 16.0 + Vector2.RIGHT * 16.0
@export var check_ceil_ray_vector   : Vector2 = Vector2.UP * 32.0

@export var dash_timer : float = .5

var dash_time          : float
var direction          : float
var under_platform     : bool

func enter() -> void:
	host.animation_playblack.travel(name)
	dash_time = dash_timer
	host.velocity.x = host.specs.dash_impulse * (1.0 if host.sprite.flip_h else -1.0)
	host.set_collision_layer_value(4, false)
	host.set_collision_mask_value(4, false)
	host.enemy_damage_area.disable_collision()
	host.ondash_collider.disabled = false
	host.body_collider.disabled = true
	direction = sign(host.velocity.x)

func exit() -> void:
	host.set_collision_layer_value(4, true)
	host.set_collision_mask_value(4, true)
	host.enemy_damage_area.enable_collision()
	host.ondash_collider.disabled = true
	host.body_collider.disabled = false

func step(delta : float) -> StateMachineState:
	under_platform = _is_under_platform()
	if under_platform:
		_advance_under_platform(delta)
	else:
		_brake(delta)
	host.fall(delta)

	host.move_and_slide()
	
	dash_time -= delta

	if ControlInput.is_jump_just_pressed(): return state_machine.on_jump
	if ControlInput.is_attack_just_pressed(): return state_machine.on_simple_attack
	if host.skills.data.super_attack and host.superattack_manager.charged() and ControlInput.is_attack_just_released(): return state_machine.on_super_attack
	if host.damager.size(): return state_machine.on_damaged
	if host.deatharea_entered: return state_machine.on_deatharea_entered
	if host.autoadvance_area and is_instance_valid(host.autoadvance_area): return state_machine.on_autoadvancing
	if dash_time < .0 and not under_platform: return state_machine.on_ground
	return self

func _is_under_platform() -> bool:
	return _is_under_platform_raycast(host.global_position + check_ceil_ray_position_l) \
	or _is_under_platform_raycast(host.global_position + check_ceil_ray_position_r)

func _is_under_platform_raycast(_origin : Vector2) -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	query.from = _origin
	query.to = _origin + check_ceil_ray_vector
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	query.exclude = [host.get_rid()]
	var result = host.space_state.intersect_ray(query)
	return result.size() > 0

func _advance_under_platform(_delta : float) -> void:
	host.velocity.x = move_toward(host.velocity.x, 100.0 * direction, host.specs.dash_deceleration)

func _brake(_delta : float) -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.dash_deceleration)
