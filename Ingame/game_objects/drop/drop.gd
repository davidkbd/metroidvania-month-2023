extends RigidBody2D

class_name Drop

signal dropped

@export var crash_particles_template : PackedScene

@onready var edge_teleport_previous_linear_velocity : Vector2 = Vector2.ZERO
@onready var teleporting : bool = false

func put_in_plant() -> void:
	_crash(true)

func catch_by_player() -> void:
	_crash(false)

func _on_body_entered(_body) -> void:
	_crash(true)

func _crash(emit_particles : bool) -> void:
	if emit_particles:
		var crash_particles : CPUParticles2D = crash_particles_template.instantiate()
		get_parent().add_child(crash_particles)
		crash_particles.global_position = global_position

	emit_signal("dropped")
	queue_free()

func _physics_process(_delta : float) -> void:
	if teleporting:
		_resume_edge_teleport()
	else:
		_edge_teleport()

func _edge_teleport() -> void:
	if global_position.x < -320 and linear_velocity.x < .0 \
	or global_position.x > 320 and linear_velocity.x > .0:
		sleeping = true
		teleporting = true
		global_position.x *= -1
		edge_teleport_previous_linear_velocity = linear_velocity

func _resume_edge_teleport() -> void:
	sleeping = false
	teleporting = false
	linear_velocity = edge_teleport_previous_linear_velocity
