extends Area2D

class_name DestroyableObject

@export var particles_texture : Texture2D
@export var target_nodepath   : NodePath

@onready var particles : CPUParticles2D = $explosion_particles
@onready var target = get_node(target_nodepath)

func destroy(_destroyer : CharacterBody2D) -> void:
	if is_instance_valid(target):
		if (_destroyer.position.x - position.x) < .0:
			particles.direction.x = -particles.direction.x
		particles.emitting = true
		target.queue_free()

func _ready() -> void:
	particles.texture = particles_texture
