extends Area2D

@onready var player : Player = get_parent()

func _on_area_entered(area : Area2D):
	if area is RatHealth:
		_eat_rat(area)


func _eat_rat(_rat : RatHealth) -> void:
	var rat = Sprite2D.new()
	rat.texture = _rat.sprite.texture
	rat.hframes = _rat.sprite.hframes
	rat.vframes = _rat.sprite.vframes
	rat.frame = _rat.sprite.frame
	rat.scale = _rat.scale
	rat.scale.y = -1.0
	rat.position = Vector2.UP * 12.0
	rat.modulate.a = .75
	player.add_child(rat)

	player.life.increment_value(1.0)
	_rat.queue_free()
	
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(rat, "modulate:a", .0, 2.0)
	await tween.finished
	if is_instance_valid(rat):
		rat.queue_free()
