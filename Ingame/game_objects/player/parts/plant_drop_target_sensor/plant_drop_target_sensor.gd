extends Area2D

func _on_area_entered(_area):
	get_parent().drop_cube(false)
