extends Node
class_name PlayerSuperAttackManager

@export var charge_seconds : float = 2.0

@onready var charging : bool = false

var time : float

func player_listener_on_skills_updated(_data : Dictionary) -> void:
	set_process(_data.super_attack)

func charged() -> bool:
	return charging and time <= .0

func reset_charge() -> void:
	charging = false
	time = charge_seconds

func _process(_delta : float) -> void:
	if ControlInput.is_attack_just_pressed():
		charging = true
		time = charge_seconds
	elif ControlInput.is_attack_just_released():
		charging = false

	if charging:
		time -= _delta

func _ready() -> void:
	set_process(false)
