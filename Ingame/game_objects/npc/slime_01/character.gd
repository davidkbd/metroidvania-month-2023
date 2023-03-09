extends NPC

var value : int = 0

func get_texts() -> Array[String]:
	return [
		"Welcome little one!",
		"You came here for a reason",
		"Those filthy ones who call themselves heroes are ruinig the underground",
		"Go outside and stop them.\nBut beware...",
		"There are other upset creatures that will attack anyone they don't know",
		"Try your best and please, save us"
	]

func pass_step() -> bool:
	return true
