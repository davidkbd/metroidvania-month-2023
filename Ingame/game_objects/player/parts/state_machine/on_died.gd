extends StateMachineState

@export var finished_timer : float = 2.0
@export var fade_timer : float = 1.0

var finished_time : float
var fade_time     : float
var fade_is_executed : bool

func enter() -> void:
	host.animation_playblack.travel(name)
	finished_time = finished_timer
	fade_time = fade_timer
	fade_is_executed = false
	host.enemy_damage_area.disable_collision()
	host.enemy_damage_area.disable_ignored_invulnerability_collision()
	host.superattack_manager.reset_charge()

func exit() -> void:
	host.reapear_sfx.play()
	host.velocity = Vector2.ZERO
	get_tree().call_group("PLAYER_LISTENER", "player_listener_on_died")

func step(_delta : float) -> StateMachineState:
	_movement(_delta)
	host.fall(_delta)
	host.move_and_slide()
	finished_time -= _delta
	fade_time -= _delta
	if finished_time < .0: return state_machine.on_ground
	if not fade_is_executed and fade_time < .0:
		fade_is_executed = true
		get_tree().call_group("PLAYER_LISTENER", "player_listener_on_predied")
	return self

func _movement(_delta : float) -> void:
	host.velocity.x = move_toward(host.velocity.x, .0, host.specs.air_deceleration)
