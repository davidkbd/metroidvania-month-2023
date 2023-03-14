extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	$talk_sfx.play()
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"Hey! Finally some friendly face",
		"I got trapped here because of those fairies",
		"Can you get rid of them for me please?"
	]
