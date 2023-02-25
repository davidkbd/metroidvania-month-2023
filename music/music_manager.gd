extends Node

@export_range(.1, 10.0) var fade_time : float = 3.0

@onready var menu_music     : AudioStreamPlayer = $menu_music
@onready var ingame_music   : Array[Node] = [
	$room_001, $room_002_tunnel
]
@onready var _current       : AudioStreamPlayer = null
@onready var _previous      : AudioStreamPlayer = null

func hud_listener_on_level_closed() -> void:
	_play(menu_music)

func hud_listener_on_game_finished() -> void:
	_stop()

func room_listener_on_activated(room : Room) -> void:
	var _next : AudioStreamPlayer = find_child(room.name)
	if not is_instance_valid(_next):
		print("ERROR, no existe el audiostreamplayer")
		return
	if _current == _next: return
	_play(_next)

func menu_listener_on_game_finished_done() -> void:
	_play(menu_music)

func _play(_music : AudioStreamPlayer) -> void:
	_previous = _current
	_current = _music
	var tween : Tween = get_tree().create_tween().bind_node(self)
	tween.set_trans(Tween.TRANS_CUBIC)
	_current.play(randf_range(.0, _current.stream.get_length()))
	tween.set_ease(Tween.EASE_OUT).tween_property(_current, "volume_db", 0, fade_time)
	if _previous:
		_current.seek(_previous.get_playback_position())
		tween.set_ease(Tween.EASE_IN).parallel().tween_property(_previous, "volume_db", -80, fade_time)
		await tween.finished
		_previous.stop()

func _stop() -> void:
	_previous = _current
	_current = null
	var tween : Tween = get_tree().create_tween().bind_node(self)
	tween.set_trans(Tween.TRANS_CUBIC)
	if _previous:
		tween.set_ease(Tween.EASE_IN).parallel().tween_property(_previous, "volume_db", -80, fade_time)
		await tween.finished
		_previous.stop()

func _ready() -> void:
	for music in get_children():
		if music is AudioStreamPlayer:
			music.stop()
			music.volume_db = -80
	_play(menu_music)
