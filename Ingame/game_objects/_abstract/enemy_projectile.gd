extends CharacterBody2D
class_name EnemyProjectile

@export var speed : float = 200.0

@onready var sprite            : Sprite2D       = $sprite
@onready var tail_particles    : CPUParticles2D = $tail_particles
@onready var destroy_particles : CPUParticles2D = $destroy_particles
@onready var light             : PointLight2D   = $light
@onready var player_sensor     : Area2D         = $player_sensor

func _on_player_sensor_body_entered(body):
	_destroy()

func _destroy() -> void:
	set_physics_process(false)
	sprite.queue_free()
	velocity = Vector2.ZERO
	collision_mask = 0
	collision_layer = 0
	player_sensor.collision_mask = 0
	player_sensor.collision_layer = 0
	tail_particles.emitting = false
	destroy_particles.emitting = true
	var light_tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	light.texture_scale = 1.0
	light_tween.tween_property(light, "texture_scale", .0, 1.0)
	light_tween.parallel().tween_property(light, "energy", .0, 1.0)
	await light_tween.finished
	queue_free()
