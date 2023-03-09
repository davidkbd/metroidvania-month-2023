extends NPC

var value : int = 0

func get_texts() -> Array[String]:
	return [
		"Hey! Finally some friendly face",
		"I got trapped here because of those fairies",
		"Can you get rid of them for me please?"
	]

func pass_step() -> bool:
	return true
