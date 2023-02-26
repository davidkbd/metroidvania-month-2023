extends EnemyCharacterAlive

@onready var center                : Node2D = $Center
@onready var animation             : AnimationPlayer  = $AnimationPlayer
@onready var sword_collider        : CollisionShape2D = $sword_area/SwordCollider
@onready var attack_foot_particles : CPUParticles2D   = $attack_foot_particles
@onready var explode_particles     : Array = [ $explode_color1, $explode_color2, $explode_color3 ]

var value : int = 0

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction
	sword_collider.position = Vector2.LEFT * (-32.0) * walk_direction
	attack_foot_particles.position.x = 16.0 * walk_direction

func attack_impulse() -> void:
	velocity.x = specs.attack_impulse * walk_direction
	attack_foot_particles.restart()
	attack_foot_particles.emitting = true

func update_room_data(_data : Dictionary) -> void:
	print("NPC LOADED DATA: ", _data)
	if _data.size() == 0:
		value = 0
	else:
		value = _data.value
	value += 1
	call_deferred("_update_room_data")

func _update_room_data() -> void:
	get_parent().update_instance_data({ "storeable": true, "value": value })

func _ready() -> void:
	collision_areas.append($sword_area)
	collision_areas.append($body_area)
	specs = CharacterAliveSpecs.get_knight_specs()
	sword_collider.disabled = true
	call_deferred("_update_room_data")
