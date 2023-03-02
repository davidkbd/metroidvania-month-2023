extends Node
class_name PlayerSuperAttackManager

@export var charge_seconds         : float = 2.0
@export var light_energy_increment : float = 1.5

@onready var charging     : bool = false
@onready var player       : Player = get_parent()

var time : float
var color_intensity : float

func player_listener_on_skills_updated(_data : Dictionary) -> void:
	set_process(_data.super_attack)

func charged() -> bool:
	return charging and time <= .0

func reset_charge() -> void:
	charging = false
	time = charge_seconds
	color_intensity = 1.0
	player.sprite.modulate = Color.WHITE

func _process(_delta : float) -> void:
	if ControlInput.is_attack_just_pressed():
		charging = true
		time = charge_seconds
		color_intensity = 1.0
	elif ControlInput.is_attack_just_released():
		charging = false

	if charging:
		player.sprite.modulate = Color(color_intensity, color_intensity, color_intensity, 1)
		time -= _delta
		color_intensity = clamp(color_intensity + _delta, 0.0, 1.3)
	else:
		player.sprite.modulate = Color.WHITE

func _ready() -> void:
	set_process(false)

