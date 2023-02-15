extends Camera2D

class_name VerticalStepsCamera

var _movement_tween : Tween
var _destination : float

func event_trigger_listener_on_touched(emitter : Node2D, trigger_id : String) -> void:
	if trigger_id.begins_with("camera_event_trigger"):
		_move_camera(emitter.global_position.y)

func _move_camera(position_y : float) -> void:
	if _destination != position_y:
		if _movement_tween:
			_movement_tween.kill()
		
		_movement_tween = get_tree().create_tween()
		_movement_tween \
				.tween_property(self, "global_position:y", position_y, .5) \
				.set_ease(Tween.EASE_IN_OUT) \
				.set_trans(Tween.TRANS_SINE)

	_destination = position_y

func _ready() -> void:
	current = true
