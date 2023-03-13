extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"Have you found the dash yet?",
		"You can avoid enemy attacks among some other uses"
	]
