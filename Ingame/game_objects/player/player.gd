extends CharacterAlive

class_name Player

@export var check_snap_wall_ray_position    : Vector2 = Vector2.UP * 56.0
@export var check_snap_wall_ray_vector      : Vector2 = Vector2.LEFT * 48.0
@export var check_snap_wall_ray_ceil_vector : Vector2 = Vector2.UP * 64.0
@export var check_attack_down_ray_position  : Vector2 = Vector2.UP * 16.0
@export var check_attack_down_ray_vector    : Vector2 = Vector2.DOWN * 96.0

@onready var life                 : PlayerLife               = $life
@onready var skills               : PlayerSkills             = $skills
@onready var superattack_manager  : PlayerSuperAttackManager = $superattack_manager
@onready var body_collider        : CollisionShape2D         = $body_collider
@onready var onwall_collider      : CollisionShape2D         = $onwall_collider
@onready var ondash_collider      : CollisionShape2D         = $ondash_collider
@onready var savepoint_sensor     : Area2D                   = $savepoint_sensor
@onready var restartpoint_sensor  : Area2D                   = $restartpoint_area_sensor

@onready var enemy_hit_area       : Area2D                   = $enemy_hit_area
@onready var enemy_damage_area    : Area2D                   = $enemy_damage_area

@onready var whoosh_sfx           : Array                    = [ $whoosh1, $whoosh2, $whoosh3, $whoosh4 ]
@onready var super_attack_charge_sfx : AudioStreamPlayer     = $super_attack_charge
@onready var dash_sfx             : AudioStreamPlayer        = $dash_sfx
@onready var jump_sfx             : AudioStreamPlayer        = $jump_sfx
@onready var damaged_sfx          : AudioStreamPlayer        = $damaged_sfx
@onready var hitenemy_sfx         : AudioStreamPlayer        = $hitenemy_sfx
@onready var slurp_sfx            : AudioStreamPlayer        = $slurp_sfx
@onready var reapear_sfx          : AudioStreamPlayer        = $reapear_sfx

var talking_npc       : NPC                 = null
var eating_enemy      : EnemyCharacterAlive = null

var damager           : Dictionary          = {}
var hitted_enemy      : EnemyCharacterAlive = null

var deatharea_entered : bool                = false
var autoadvance_area  : AutoadvanceArea     = null
var walk_direction    : float

func initialize(_game_state : Dictionary) -> void:
	skills.initialize(_game_state)
	life.initialize(_game_state)

func reset_to_savepoint(_savepoint : Node2D) -> void:
	global_position = _savepoint.global_position
	talking_npc = null
	damager = {}
	hitted_enemy = null
	autoadvance_area = null
	velocity = Vector2.ZERO
	superattack_manager.reset_charge()
	enemy_damage_area.reset()

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction

func can_snap_to_wall() -> bool:
	if not is_on_wall(): return false
	
	# Compruebo si hay una pared a la que agarrarse
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	var origin : Vector2 = global_position + check_snap_wall_ray_position
	query.from = origin
	query.to = origin + check_snap_wall_ray_vector * Vector2.LEFT * sign(walk_direction)
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	query.exclude = [get_rid()]
	var result = space_state.intersect_ray(query)
	if result.size() == 0: return false
	
	if result.normal - Vector2.LEFT != Vector2.ZERO \
	and result.normal - Vector2.RIGHT != Vector2.ZERO:
		return false

	
	# Compruebo si el techo esta demasiado bajo
	query = PhysicsRayQueryParameters2D.new()
	query.from = global_position
	query.to = global_position + check_snap_wall_ray_ceil_vector
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	query.exclude = [get_rid()]
	result = space_state.intersect_ray(query)
	if result.size() > 0: return false
	
	return true

func can_attack_down() -> bool:
	if is_on_floor(): return false
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	var origin : Vector2 = global_position + check_attack_down_ray_position
	query.from = origin
	query.to = origin + check_attack_down_ray_vector
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	query.exclude = [get_rid()]
	var result = space_state.intersect_ray(query)
	return result.size() == 0

func entered_in_death_area() -> void:
	if life.is_died(): return
	if restartpoint_sensor.last_restartpoint and is_instance_valid(restartpoint_sensor.last_restartpoint):
		deatharea_entered = true

func _ready() -> void:
	get_tree().call_deferred(
			"call_group",
			"PLAYER_LISTENER",
			"player_listener_on_ready",
			self)
	global_position = Vector2.ONE * 9999999999.0
	
	print("Ponemos todas las skills pero esto hay que quitarlo")
	#esto esta en el ProgressManager, en el default gamestate
#	skills.set_skill_value("super_attack", true)
#	skills.set_skill_value("double_jump", true)
#	skills.set_skill_value("dash", true)
#	skills.set_skill_value("snap_wall", true)
#	skills.set_skill_value("drop_attack", true)
