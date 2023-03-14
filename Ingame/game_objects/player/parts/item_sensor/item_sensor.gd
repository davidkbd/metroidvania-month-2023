extends Area2D

@onready var player : Player = get_parent()

func _on_area_entered(area : Area2D):
	if area is RatHealthItem:
		_eat_rat(area)
	elif area is SkillItem:
		_get_double_jump(area)

func _eat_rat(_rat : RatHealthItem) -> void:
	var rat = Sprite2D.new()
	rat.texture = _rat.sprite.texture
	rat.hframes = _rat.sprite.hframes
	rat.vframes = _rat.sprite.vframes
	rat.frame = _rat.sprite.frame
	rat.scale = _rat.scale
	rat.scale.y = -1.0
	rat.position = Vector2.UP * 4.0
	rat.modulate.a = .75
	player.add_child(rat)

	player.life.increment_value(1.0)
	_rat.catch()
	
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(rat, "modulate:a", .0, 2.0)
	player.slurp_sfx.play()
	await tween.finished
	if is_instance_valid(rat):
		rat.queue_free()

func _get_double_jump(_item : SkillItem) -> void:
	player.skills.set_skill_value(
			_item.get_skill_name(),
			true)
	_item.catch()
