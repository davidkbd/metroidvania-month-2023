extends Node
class_name MusicManager

enum OstItem {
	SILENT,
	CAVERNS_INITIAL,
	CAVERNS,
	CAVERNS_BATTLE,
	LONELY,
	SAVEPOINT,
	SEWERS,
	SEWERS_BATTLE
}

@export_range(.1, 10.0) var fade_time : float = 1.0

@onready var menu_music     : AudioStreamPlayer = $menu_music
@onready var _current       : AudioStreamPlayer = null
@onready var _previous      : AudioStreamPlayer = null

var crossfade_tween : Tween

func hud_listener_on_level_closed() -> void:
	_play(menu_music)

func hud_listener_on_game_finished() -> void:
	_stop()

func room_listener_on_activated(room : Room) -> void:
	# deferred porque la instancia de enemigos se hace deferred
	# y si no esta peticion llegaria antes de estar hecho
	call_deferred("_room_activated", room)

func room_listener_on_cleared(room : Room) -> void:
	_room_activated(room)

func menu_listener_on_game_finished_done() -> void:
	_play(menu_music)

func _room_activated(room : Room) -> void:
	var _next : AudioStreamPlayer = _find_audio_stream_player(room.battle_ost_item if room.is_any_enemy_alive() else room.ost_item)
	if not is_instance_valid(_next):
		_stop()
		return
	if _current == _next: return
	_play(_next)

func _find_audio_stream_player(_ost_item : OstItem) -> AudioStreamPlayer:
	match _ost_item:
		OstItem.SILENT:            return $silent
		OstItem.CAVERNS_INITIAL:   return $caverns_initial
		OstItem.CAVERNS:           return $caverns
		OstItem.CAVERNS_BATTLE:    return $caverns_battle
		OstItem.LONELY:            return $lonely
		OstItem.SAVEPOINT:         return $savepoint
		OstItem.SEWERS:            return $sewers
		OstItem.SEWERS_BATTLE:     return $sewers_battle
	return null

func _play(_music : AudioStreamPlayer) -> void:
	_previous = _current
	_current = _music
	if crossfade_tween: crossfade_tween.kill()
	crossfade_tween = create_tween()
	_current.play()#randf_range(.0, _current.stream.get_length()))
#	crossfade_tween.set_trans(Tween.TRANS_CUBIC)
	crossfade_tween.set_trans(Tween.TRANS_CUBIC)
	crossfade_tween.set_ease(Tween.EASE_OUT).tween_property(_current, "volume_db", 0, fade_time)
	if _previous:
		_current.seek(_previous.get_playback_position())
		crossfade_tween.set_ease(Tween.EASE_IN).parallel().tween_property(_previous, "volume_db", -80, fade_time)
		await crossfade_tween.finished
		_previous.stop()

func _stop() -> void:
	_previous = _current
	_current = null
	if _previous:
		if crossfade_tween: crossfade_tween.kill()
		crossfade_tween = create_tween()
		crossfade_tween.set_trans(Tween.TRANS_CUBIC)
		crossfade_tween.set_ease(Tween.EASE_IN).parallel()
		crossfade_tween.tween_property(_previous, "volume_db", -80, fade_time)
		await crossfade_tween.finished
		if _previous == null:
			print("No entiendo que es lo que puede producir este _previous == null")
			print("Lo soluciono con un return pero este un posible punto donde aparezcan bugs...")
			return
		_previous.stop()

func _ready() -> void:
	for music in get_children():
		if music is AudioStreamPlayer:
			music.stop()
			music.volume_db = -80
	_play(menu_music)
