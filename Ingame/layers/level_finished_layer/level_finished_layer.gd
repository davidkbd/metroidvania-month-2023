extends CanvasLayer

@export var show_animation_background_seconds : float = 5.0
@export var show_animation_score_seconds      : float = 1.0
@export var buttons_delay_seconds             : float = .5
@export var buttons_animation_seconds         : float = 1.0

@onready var score              : Control = $finish/score
@onready var background         : Control = $finish/background
@onready var stars              : Control = $finish/stars
@onready var retry_button       : TextureButton  = $finish/score/retry_button
@onready var next_button        : TextureButton  = $finish/score/next_button
@onready var quit_button        : TextureButton  = $finish/score/quit_button
@onready var next_button_particles : CPUParticles2D = $finish/score/next_button/particles
@onready var win_sfx            : AudioStreamPlayer = $win_sfx
@onready var lose_sfx           : AudioStreamPlayer = $lose_sfx

@onready var stars_position = stars.position
@onready var score_position = score.position

var current_level : Dictionary

func _get_current_level_data() -> void:
	var level : Level = get_tree().get_first_node_in_group("LEVEL")
	var path_split = level.scene_file_path.split("/")
	var level_name = path_split[path_split.size() - 2]
	current_level = Levels.find_level(level_name)

func _save_progress() -> void:
	var file_name = Directories.LEVEL_STARS_PATH + current_level.name
	var file = FileAccess.open(file_name, FileAccess.READ)
	var _readed = file.get_8() if file else 0
	
	if stars.star_count > _readed:
		if _readed == 0:
			file = FileAccess.open(Directories.RECENT_PASSED_PATH, FileAccess.WRITE)
			file.store_string(current_level.name)
			
		file = FileAccess.open(file_name, FileAccess.WRITE)
		file.store_8(stars.star_count)

func _hide_components() -> void:
	background.color.a = .0
	score.position.y -= 500.0
	stars.position.y -= 500.0
	quit_button.modulate.a = .0
	retry_button.modulate.a = .0
	next_button.hide()

func _animate_show_score() -> void:
	var tween := get_tree().create_tween().bind_node(self)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(background, "color:a", .7, show_animation_background_seconds)
	tween.parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(score, "position:y", score_position.y, show_animation_score_seconds)
	tween.parallel().tween_property(stars, "position:y", stars_position.y, show_animation_score_seconds)

func _on_stars_finished():
	if stars.star_count > 0:
#		if current_level.is_last:
#			quit_button.grab_focus()
#		else:
		await get_tree().create_timer(1.0).timeout
		next_button.show()
		win_sfx.play()
		next_button_particles.emitting = true
		next_button.grab_focus()
	else:
		lose_sfx.play()
		retry_button.grab_focus()
	
	var tween := get_tree().create_tween().bind_node(self)
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tween.tween_property(retry_button, "modulate:a", 1.0, 2.0)
	tween.parallel().tween_property(quit_button, "modulate:a", 1.0, 2.0)

	await tween.finished

func _on_retry_button_pressed():
	get_tree().call_group("HUD_LISTENER", "hud_listener_on_level_restarted")

func _on_next_button_pressed():
	if current_level.is_last:
		get_tree().call_group("HUD_LISTENER", "hud_listener_on_game_finished")
	else:
		get_tree().call_group("HUD_LISTENER", "hud_listener_on_level_passed")

func _on_quit_button_pressed():
	get_tree().call_group("HUD_LISTENER", "hud_listener_on_level_closed")

func _ready() -> void:
	_get_current_level_data()
	_save_progress()
	_hide_components()
	_animate_show_score()
