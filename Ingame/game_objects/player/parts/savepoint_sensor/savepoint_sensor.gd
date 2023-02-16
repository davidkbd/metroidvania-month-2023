extends Area2D

@onready var timer : Timer = $temporarily_deactivate_timer
@onready var enabled : bool = false

func temporarily_deactivate() -> void:
	timer.start(1.0)
	enabled = false

func _on_area_entered(area : SavepointArea):
	if enabled:
		area.activate()

func _on_temporarily_deactivate_timer_timeout():
	enabled = true
