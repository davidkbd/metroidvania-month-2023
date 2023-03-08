extends EnemyCharacterAlive

@onready var navigation_agent      : NavigationAgent2D = $navigation_agent
@onready var center                : Node2D = $Center
@onready var animation             : AnimationPlayer   = $AnimationPlayer
@onready var sword_collider        : CollisionShape2D  = $sword_area/SwordCollider
@onready var attack_foot_particles : CPUParticles2D    = $attack_foot_particles
@onready var explode_particles     : Array = [ $explode_color1, $explode_color2, $explode_color3 ]

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction
	sword_collider.position = Vector2.LEFT * (-32.0) * walk_direction
	attack_foot_particles.position.x = 16.0 * walk_direction

func attack_impulse() -> void:
	velocity.x = specs.attack_impulse * walk_direction
	attack_foot_particles.restart()
	attack_foot_particles.emitting = true

func _ready() -> void:
	collision_areas.append($sword_area)
	collision_areas.append($body_area)
	specs = CharacterAliveSpecs.get_fairy_specs()
	sword_collider.disabled = true
