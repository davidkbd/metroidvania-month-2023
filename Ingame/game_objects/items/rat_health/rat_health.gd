extends Area2D

class_name RatHealth

@onready var sprite          : Sprite2D  = $sprite
@onready var center_floor_rc : RayCast2D = $center_floor
@onready var front_floor_rc  : RayCast2D = $front_floor_rc
@onready var front_wall_rc   : RayCast2D = $front_wall_rc

@onready var space_state = get_world_2d().get_direct_space_state()

@onready var is_on_floor : bool = false
@onready var need_change : bool = false
@onready var change_time : float = .5
@onready var direction   : int  = 1.0

@onready var velocity : Vector2 = Vector2.ZERO

func _process(_delta : float) -> void:
	is_on_floor = center_floor_rc.is_colliding()
	
	need_change = is_on_floor \
			and (not front_floor_rc.is_colliding() or front_wall_rc.is_colliding())
	
	if need_change:
		change_time -= _delta
		velocity.x = .0
		if change_time < .0:
			direction = -direction
			change_time = .5
	else:
		if is_on_floor:
			_move(_delta)
			_snap_to_floor(_delta)
	if not is_on_floor:
		_fall(_delta)
	
	scale.x = -direction
	global_position += velocity * _delta

func _fall(_delta : float) -> void:
	velocity.y += _delta * 800.0

func _snap_to_floor(_delta) -> void:
	if center_floor_rc.is_colliding():
		velocity.y = .0
		global_position.y = center_floor_rc.get_collision_point().y

func _move(_delta : float) -> void:
	velocity.x = _delta * direction * 1900.0

func _check_wall() -> void:
	pass
