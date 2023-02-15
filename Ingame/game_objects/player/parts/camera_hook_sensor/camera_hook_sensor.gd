extends Area2D


func _on_area_entered(area):
	area.enable()

func _on_area_exited(area):
	area.disable()
