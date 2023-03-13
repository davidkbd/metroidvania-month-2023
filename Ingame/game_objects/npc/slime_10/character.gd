extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"Consume dead bodies to gain power",
		"Just look up when you found any"
	]
