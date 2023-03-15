extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	$talk_sfx.play()
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"Check this flower with energy from the roots of the underground",
		"That one lets you stick into a wall and jump to the other direction",
		"Just jump on a wall to stick to it, and jump again facing the other direction",
		"It's so funny, give it a try"
	]
