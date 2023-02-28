extends Area2D
class_name PlayerRestartPointSensor

var last_restartpoint : RestartPointArea

func _on_area_entered(area : RestartPointArea) -> void:
	last_restartpoint = area
