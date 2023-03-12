extends EnemyCharacterAlive

@export var projectile_template         : PackedScene

@onready var navigation_agent           : NavigationAgent2D = $navigation_agent
@onready var center                     : Node2D            = $Center
@onready var animation                  : AnimationPlayer   = $AnimationPlayer
@onready var body_area                  : Area2D            = $body_area
@onready var body_collider              : CollisionShape2D  = $body_area/body_collider
@onready var explode_particles          : Array = [ $explode_color1, $explode_color2, $explode_color3 ]
@onready var projectile_output_position : Marker2D = $projectile_output_position

@onready var default_position      : Vector2 = global_position

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction
	projectile_output_position.position.x = 14 * sign(_direction)

func throw_projectile() -> void:
	var projectile_instance = projectile_template.instantiate()
	get_parent().add_child(projectile_instance)
	projectile_instance.global_position = projectile_output_position.global_position
	if player:
		var diff = global_position - player.global_position
		projectile_instance.rotation = diff.angle()
		velocity.x = cos(diff.angle()) * specs.throw_projectile_feedback_impulse
		velocity.y = sin(diff.angle()) * specs.throw_projectile_feedback_impulse

func _ready() -> void:
	super._ready()
	collision_areas.append(body_area)
	specs = CharacterAliveSpecs.get_fairy_specs()

