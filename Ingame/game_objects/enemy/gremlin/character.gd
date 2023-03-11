extends EnemyCharacterAlive

@onready var center                : Node2D = $Center
@onready var wall_sensor           : RayCast2D = $wall_sensor
@onready var wall_top_sensor       : RayCast2D = $wall_top_sensor
@onready var floor_sensor          : RayCast2D = $floor_sensor
@onready var animation             : AnimationPlayer  = $AnimationPlayer
@onready var sword_collider        : CollisionShape2D = $sword_area/SwordCollider
@onready var attack_foot_particles : CPUParticles2D   = $attack_foot_particles
@onready var explode_particles     : Array = [ $explode_color1, $explode_color2, $explode_color3 ]

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction
	sword_collider.position = Vector2.LEFT * (-40.0) * walk_direction
	attack_foot_particles.position.x = 16.0 * walk_direction
	wall_sensor.target_position.x = 48.0 * walk_direction
	wall_top_sensor.target_position = wall_sensor.target_position
	floor_sensor.position.x = 32.0 * walk_direction

func attack_impulse(_impulse_count : int) -> void:
	if player:
		set_walk_direction(sign(player.global_position.x - global_position.x))

	if _impulse_count == 1:
		velocity.x = specs.attack_impulse * walk_direction
	elif _impulse_count == 2:
		velocity.x = specs.attack_second_impulse * walk_direction
		velocity.y = -specs.attack_second_impulse
	attack_foot_particles.restart()
	attack_foot_particles.emitting = true

func _ready() -> void:
	collision_areas.append($sword_area)
	collision_areas.append($body_area)
	specs = CharacterAliveSpecs.get_gremlin_specs()
	sword_collider.disabled = true
