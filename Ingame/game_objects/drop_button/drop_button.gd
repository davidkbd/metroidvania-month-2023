extends EventTrigger

@export var toggle_delay_seconds : float = -1.0
@export var show_countdown       : bool = true

@onready var sprite       : Sprite2D = $sprite
@onready var toggle_timer : Timer    = $toggle_timer
@onready var numbers_sprites = [ $numbers_sprite, $numbers2_sprite ]
@onready var countdown_sfx = $countdown_sfx
@onready var toggle_sfx    = $toggle_sfx

var countdown : float

func _on_body_entered(_body) -> void:
	set_collision_mask_value(8, false)
	if toggle_delay_seconds >= .0:
		countdown = toggle_delay_seconds
		_update_numbers()
		toggle_timer.start(1)
	_toggle_frame()
	get_tree().call_group(
			"EVENT_TRIGGER_LISTENER",
			"event_trigger_listener_on_button_enabled",
			self,
			trigger_id)

func _on_toggle_timer_timeout() -> void:
	countdown -= 1.0
	_update_numbers()
	if countdown > 0:
		toggle_timer.start(1)
	else:
		set_collision_mask_value(8, true)
		_toggle_frame()
		get_tree().call_group(
				"EVENT_TRIGGER_LISTENER",
				"event_trigger_listener_on_button_disabled",
				self,
				trigger_id)

func _update_numbers() -> void:
	if show_countdown:
		countdown_sfx.play()
		numbers_sprites[1].frame = int(floor(countdown) / 10)
		numbers_sprites[0].frame = int(floor(countdown)) % 10

func _toggle_frame() -> void:
	toggle_sfx.play()
	var next_frame
	if sprite.frame == 0:
		next_frame = 2
	else:
		next_frame = 0
	var tween = get_tree().create_tween().bind_node(self)
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(sprite, "frame", next_frame, .2)

func _ready() -> void:
	numbers_sprites[0].visible = show_countdown and toggle_delay_seconds >= .0
	numbers_sprites[1].visible = show_countdown and toggle_delay_seconds >= .0
