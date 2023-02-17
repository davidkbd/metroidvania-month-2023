extends Node2D
class_name RoomContent

func activate() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func deactivate() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func get_state() -> Dictionary:
	print("Hay que recorrer todos los spawners y asi sabemos cuales enemigos han muerto")
	# tambien hay que hacer algo que nos permita saber si esta informacion ha de ser almacenada
	# en disco, o solo en memoria
	return {}

func _enter_tree() -> void:
	deactivate()

