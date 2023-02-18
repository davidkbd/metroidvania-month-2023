extends ColorRect

@export var fade_seconds : float = 1.0

var tween : Tween

func hud_listener_on_level_closed() -> void:
	_fade_in()

func menu_listener_on_game_start_requested(_slot_name : String) -> void:
	_fade_out()

func hud_listener_on_level_restarted() -> void:
	_fade_out()

func hud_listener_on_game_finished() -> void:
	_fade_out()

func level_listener_on_ready(_data : Dictionary) -> void:
	_fade_in()

func _fade_in() -> void:
	_fade(1.0, 0.0)

func _fade_out() -> void:
	_fade(0.0, 1.0)

func _fade(from : float, to : float) -> void:
	color.a = from
	if tween: tween.kill()
	tween = get_tree().create_tween().bind_node(self)
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "color:a", to, fade_seconds)

func _ready() -> void:
	_fade_in()
