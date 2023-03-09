extends EnemyProjectile

func _physics_process(_delta : float) -> void:
	velocity.x = -cos(rotation) * speed
	velocity.y = -sin(rotation) * speed
	
	if move_and_slide():
		_destroy()
