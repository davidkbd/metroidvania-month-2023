extends RigidBody2D

class_name Drop

signal dropped

@export var crash_particles_template : PackedScene

func _on_body_entered(_body) -> void:
	_crash(true)

func _crash(emit_particles : bool) -> void:
	if emit_particles:
		var crash_particles : CPUParticles2D = crash_particles_template.instantiate()
		get_parent().add_child(crash_particles)
		crash_particles.global_position = global_position

	emit_signal("dropped")
	queue_free()
