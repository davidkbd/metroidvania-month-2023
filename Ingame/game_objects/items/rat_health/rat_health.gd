extends Area2D

class_name RatHealth

@export  var fall_accel      : float = 800.0
@export  var speed           : float = 7000.0

@onready var sprite            : Sprite2D  = $sprite
@onready var center_floor_rc   : RayCast2D = $center_floor
@onready var front_floor_rc    : RayCast2D = $front_floor_rc
@onready var front_wall_rc     : RayCast2D = $front_wall_rc
@onready var animation         : AnimationPlayer = $AnimationPlayer
@onready var walk_timer        : Timer = $WalkTimer

@onready var space_state = get_world_2d().get_direct_space_state()

@onready var is_on_floor : bool = false
@onready var need_change : bool = false
@onready var change_time : float = .5
@onready var direction   : int  = 1.0

@onready var velocity : Vector2 = Vector2.ZERO
@onready var timer

var walk_timer_flag : bool

var catched : bool

func catch() -> void:
	catched = true
	sprite.hide()
	collision_layer = 0
	collision_mask = 0
	set_process(false)
	set_physics_process(false)

func _physics_process(_delta : float) -> void:
	is_on_floor = center_floor_rc.is_colliding()
	
	need_change = need_change or (
	is_on_floor and (not front_floor_rc.is_colliding() or front_wall_rc.is_colliding()))
	
	if need_change:
		change_time -= _delta
		velocity.x = .0
		if change_time < .0:
			direction = -direction
			change_time = 1.0
			need_change = false
	else:
		if is_on_floor:
			_move(_delta)
			_snap_to_floor(_delta)
	if not is_on_floor:
		_fall(_delta)
	
	scale.x = -direction
	global_position += velocity * _delta

func _process(_delta : float) -> void:
	animation.play("walk" if velocity.x else "idle")

func _fall(_delta : float) -> void:
	velocity.y += _delta * fall_accel

func _snap_to_floor(_delta) -> void:
	if center_floor_rc.is_colliding():
		velocity.y = .0
		global_position.y = center_floor_rc.get_collision_point().y

func _move(_delta : float) -> void:
	velocity.x = _delta * direction * speed
	if (walk_timer_flag == false):
		need_change = true
		start_walk_timer()

func _on_walk_timer_timeout():
	walk_timer_flag = false

func start_walk_timer():
	walk_timer_flag = true
	walk_timer.start(randi_range(3,7))

func _ready():
	for player in get_tree().get_nodes_in_group("PLAYER"):
		center_floor_rc.add_exception(player)
		front_floor_rc.add_exception(player)
		front_wall_rc.add_exception(player)
