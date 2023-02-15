extends Node2D

class_name Plant

@export var grow_time        : float = 1.0

var health_increment : float
var grow_step_size   : int
var max_drop_count   : int

@onready var health_timer    : Timer            = $health_timer
@onready var plant_body      : Node2D           = $plant_body
@onready var stem_sprite     : Sprite2D         = $plant_body/body/stem_sprite
@onready var stem_area_col   : CollisionShape2D = $plant_body/damage_area/stem_collider
@onready var grass_particles : CPUParticles2D   = $grass_particles
@onready var grow_sfx        : AudioStreamPlayer = $grow_sfx

@onready var drop_count     : float = .0
@onready var health         : float = 1.0

var grow_tween : Tween

func level_listener_on_ready(level_data : Dictionary) -> void:
	if level_data.has("plant"):
		health_increment = level_data.plant.health_increment
		grow_step_size = level_data.plant.grow_step_size
		max_drop_count = level_data.plant.max_drop_count

func beetle_eating(amount : float) -> void:
	drop_count = clamp(drop_count - amount, .0, max_drop_count)
	_update_grow()
	grass_particles.emitting = true
	get_tree().call_group("PLANT_LISTENER", "plant_listener_on_got_water")

func _on_plant_body_entered(drop : Drop):
	grow_sfx.play()
	drop_count = clamp(drop_count + 1.0, .0, max_drop_count)
	health = clamp(health + health_increment, .0, 1.0)
	_update_grow()
	drop.put_in_plant()
	grass_particles.emitting = true
	get_tree().call_group("PLANT_LISTENER", "plant_listener_on_got_water")
	get_tree().call_group("PLANT_LISTENER", "plant_listener_on_health_changed")
	health_timer.start()

func _on_health_timer_timeout():
	health -= .01
	get_tree().call_group("PLANT_LISTENER", "plant_listener_on_health_changed")

func _update_grow() -> void:
	if grow_tween: grow_tween.kill()
	var height : float = drop_count * grow_step_size
	stem_sprite.region_rect.size.y = height + 128.0
	var shape : RectangleShape2D = stem_area_col.shape
	shape.size.y = height
	stem_area_col.position.y = height * .5
	grow_tween = get_tree().create_tween().bind_node(self)
	grow_tween.tween_property(plant_body, "position:y", -height, grow_time) \
			.set_ease(Tween.EASE_OUT) \
			.set_trans(Tween.TRANS_ELASTIC)
	await grow_tween.finished
	grow_tween.kill()
	grow_tween = null

func _exit_tree() -> void:
	if grow_tween: grow_tween.kill()
	
func _ready():
	get_tree().call_group("PLANT_LISTENER", "plant_listener_on_ready", self)
	_update_grow()
