extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	$talk_sfx.play()
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"This roots let you save the game progress",
		"Just look up when you found any",
		"This will also heal you and save the progress on that pretty map"
	]
