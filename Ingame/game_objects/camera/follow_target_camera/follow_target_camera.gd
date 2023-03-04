extends Camera2D
class_name FollowTargetCamera

@export var offset_position : Vector2 = Vector2.UP * 24.0
@export var distance_factor : float = .25

@onready var target : Node2D = get_tree().get_first_node_in_group("PLAYER")

var shake_tween      : Tween
var target_position  : Vector2
var distance         : float
var delta_speed      : float
var fading           : bool

func destroyable_listener_on_destroyed(direction : Vector2) -> void:
	if shake_tween: shake_tween.kill()
	shake_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	offset = direction * 5.0
	shake_tween.tween_property(self, "offset", Vector2.ZERO, 1.0)

func player_listener_on_damaged(player : Player) -> void:
	if shake_tween: shake_tween.kill()
	shake_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	var direction = (player.global_position - player.damager.global_position).normalized()
	offset = direction * player.damager.power
	shake_tween.tween_property(self, "offset", Vector2.ZERO, 1.0)

func player_listener_on_deatharea_restarted() -> void:
	fading = true
	await create_tween().tween_interval(.25).finished
	fading = false

func player_listener_on_autoadvance_exited(area : AutoadvanceArea) -> void:
	if area.fade_out_in:
		fading = true
		await create_tween().tween_interval(.25).finished
		fading = false

func set_target(_target : Node2D) -> void:
	target = _target

func teleport() -> void:
	target_position = round(target.global_position + offset_position)
	global_position = target_position

func _process(_delta : float) -> void:
	if fading:
		target_position = target.global_position
	else:
		distance = clamp(target_position.distance_squared_to(target.global_position), 1.0, 150.0) / 5.0
		if distance < 2.0: return

		delta_speed = _delta * distance * distance_factor
		target_position.x = lerp(target_position.x, target.global_position.x, delta_speed)
		target_position.y = lerp(target_position.y, target.global_position.y, delta_speed)
		
	global_position = round(target_position + offset_position)

func _ready() -> void:
	make_current()
