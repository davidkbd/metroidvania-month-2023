extends CharacterAlive

class_name Player

@export var check_snap_wall_ray_position   : Vector2 = Vector2.UP * 56.0
@export var check_snap_wall_ray_vector     : Vector2 = Vector2.LEFT * 64
@export var check_attack_down_ray_position : Vector2 = Vector2.UP * 16.0
@export var check_attack_down_ray_vector   : Vector2 = Vector2.DOWN * 96.0

@onready var skills               : PlayerSkills      = $skills
@onready var body_collider        : CollisionShape2D  = $body_collider
@onready var onwall_collider      : CollisionShape2D  = $onwall_collider
@onready var savepoint_sensor     : Area2D            = $savepoint_sensor
@onready var jump_sfx             : AudioStreamPlayer = $jump_sfx
@onready var damaged_sfx          : AudioStreamPlayer = $damaged_sfx
@onready var hitenemy_sfx         : AudioStreamPlayer = $hitenemy_sfx

@onready var enemy_hit_area       : Area2D            = $enemy_hit_area
@onready var enemy_damage_area    : Area2D            = $enemy_damage_area

var talking_npc   : NPC = null

var damager    : Dictionary = {}
var enemy_died : CharacterBody2D = null # este era el saltito que da al matar un enemigo en el juego del gnomo
var hitted_enemy : EnemyCharacterAlive = null

var autoadvance_area : AutoadvanceArea = null
var walk_direction   : float

func initialize(_game_state : Dictionary) -> void:
	skills.initialize(_game_state)

func set_walk_direction(_direction : float) -> void:
	walk_direction = _direction

func can_hit_endemy() -> bool:
	if enemy_died: return false
	if damager: return false
	if is_on_floor(): return false
	return velocity.y > .0

func can_double_jump() -> bool:
	return skills.data.double_jump

func can_dash() -> bool:
	return skills.data.dash

func can_snap_to_wall() -> bool:
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.new()
	var origin : Vector2 = global_position + check_snap_wall_ray_position
	query.from = origin
	query.to = origin + check_snap_wall_ray_vector * Vector2.LEFT * sign(walk_direction)
	query.collide_with_bodies = true
	query.collide_with_areas = false
	query.collision_mask = 1
	query.exclude = [get_rid()]
	var result = space_state.intersect_ray(query)
	return result.size() > 0 and is_on_wall()

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

func _ready() -> void:
	get_tree().call_deferred(
			"call_group",
			"PLAYER_LISTENER",
			"player_listener_on_ready",
			self)
	global_position = Vector2.ONE * 9999999999.0
	
	print("Ponemos todas las skills pero esto hay que quitarlo")
	skills.set_skill_value("normal_attack", false)
	skills.set_skill_value("double_jump", true)
	skills.set_skill_value("dash", true)
	skills.set_skill_value("snap_wall", true)

