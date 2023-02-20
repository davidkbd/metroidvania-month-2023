extends CPUParticles2D

func _ready():
	$Timer.start(lifetime)
	emitting = true

func _on_timer_timeout():
	queue_free()
