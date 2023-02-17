extends Node2D
class_name RoomContent

func activate() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func deactivate() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _enter_tree() -> void:
	deactivate()
