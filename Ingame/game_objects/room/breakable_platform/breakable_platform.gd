extends StaticBody2D
class_name BreakablePlatform

@export_group("Times")
@export var break_delay : float = 1.0
@export var restore_delay : float = 4.0

@onready var sprite         : Sprite2D       = $sprite
@onready var mini_particles : CPUParticles2D = $mini_particles
@onready var big_particles  : CPUParticles2D = $big_particles

var break_in_progress : bool = false

func interact() -> void:
	if break_in_progress: return
	break_in_progress = true
	_break_begin()

func _break_begin() -> void:
	set_physics_process(true)
	mini_particles.restart()
	mini_particles.emitting = true
	var tween : Tween = create_tween()
	tween.tween_property(sprite, "frame", 2, .2)
	tween.tween_interval(break_delay)
	await tween.finished
	_break()
	await create_tween().tween_interval(restore_delay).finished
	_restore()

func _break() -> void:
	set_physics_process(false)
	big_particles.restart()
	big_particles.emitting = true
	sprite.hide()
	set_collision_layer_value(1, false)
	set_collision_layer_value(11, false)

func _restore() -> void:
	set_collision_layer_value(1, true)
	set_collision_layer_value(11, true)
	sprite.position.y = .0
	sprite.show()
	sprite.frame = 0
	break_in_progress = false

func _physics_process(_delta : float) -> void:
	sprite.position.y = lerp(sprite.position.y, randf_range(-4.0, 4.0), _delta * 10.0)

func _ready() -> void:
	set_physics_process(false)
