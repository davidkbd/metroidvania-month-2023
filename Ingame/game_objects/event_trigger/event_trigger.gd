extends Area2D

class_name EventTrigger

@export var trigger_id : String = ""

func _on_body_entered(_body) -> void:
	get_tree().call_group(
			"EVENT_TRIGGER_LISTENER",
			"event_trigger_listener_on_touched",
			self,
			trigger_id)

