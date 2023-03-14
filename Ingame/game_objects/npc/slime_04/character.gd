extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	$talk_sfx.play()
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"Check that flower with energy from the roots of the underworld",
		"That one lets you snap to the wall and jump in the other direction",
		"It's so funny, give it a try"
	]
