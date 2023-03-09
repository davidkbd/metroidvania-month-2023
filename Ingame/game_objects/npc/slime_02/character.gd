extends NPC

var value : int = 0

func get_texts() -> Array[String]:
	return [
		"WOAH!\nYou scared me",
		"How you find me?",
		"Please dont' say anything about me, I don't want to go outside",
		"I don't wanna die"
	]

func pass_step() -> bool:
	return true
