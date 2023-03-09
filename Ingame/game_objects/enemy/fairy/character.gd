extends EnemyCharacterAlive

@export var projectile_template    : PackedScene

@onready var navigation_agent      : NavigationAgent2D = $navigation_agent
@onready var center                : Node2D = $Center
@onready var animation             : AnimationPlayer   = $AnimationPlayer
@onready var explode_particles     : Array = [ $explode_color1, $explode_color2, $explode_color3 ]

@onready var default_position      : Vector2 = global_position

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction

func attack_impulse() -> void:
	velocity.x = specs.attack_impulse * walk_direction

func throw_projectile() -> void:
	var projectile_instance = projectile_template.instantiate()
	get_parent().add_child(projectile_instance)
	projectile_instance.global_position = global_position
	if player:
		var diff = global_position - player.global_position
		projectile_instance.rotation = diff.angle()
		print("FALTA EL ATTACK IMPULSE DE FAIRY")

func _ready() -> void:
	collision_areas.append($body_area)
	specs = CharacterAliveSpecs.get_fairy_specs()

