extends NPC

var value : int = 0

func get_texts() -> Array[String]:
	return [
		"You know you can climb over the walls to reach high places?",
		"But it's difficult to learn the DOUBLE JUMP",
		"Do you know how to do such thing?"
	]

func pass_step() -> bool:
	return true
