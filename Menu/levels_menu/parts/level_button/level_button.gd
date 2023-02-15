extends Button

class_name LevelButton

@onready var lock = $lock
@onready var stars = $stars
@onready var star = [ $stars/star1, $stars/star2, $stars/star3 ]

var locked : bool
var level_name : String
var recent_unlock : bool
var star_count : int

func menu_listener_on_open_principal_menu_pressed() -> void:
	disabled = true

func set_locked(_locked : bool) -> void:
	locked = _locked
	disabled = locked
	if _locked:
		focus_mode = Control.FOCUS_NONE

func set_level_name(_name : String) -> void:
	level_name = _name.replace("_", " ").to_upper()
	star_count = _get_stars(_name)

func set_recent_unlock(_unlock : bool) -> void:
	recent_unlock = _unlock

func _get_stars(_name : String) -> int:
	var file_name = Directories.LEVEL_STARS_PATH + _name
	var file = FileAccess.open(file_name, FileAccess.READ)
	if file:
		return file.get_8()
	return 0

func _update_stars() -> void:
	star[0].visible = star_count > 0
	star[1].visible = star_count > 1
	star[2].visible = star_count > 2

func _ready() -> void:
	if locked:
		lock.show()
		text = ""
		stars.hide()
	else:
		lock.hide()
		text = level_name
		_update_stars()
		if recent_unlock:
			lock.show()
			get_tree().call_group("MENU_SFX", "play_level_unlock")
			var tween : Tween = get_tree().create_tween().bind_node(self)
			tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(lock, "frame", lock.hframes - 1, 1.0)
			tween.tween_property(lock, "modulate:a", .0, 1.0)
			await tween.finished
			lock.hide()
			
