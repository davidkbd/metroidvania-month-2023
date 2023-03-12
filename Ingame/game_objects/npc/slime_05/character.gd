extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"You know you can climb over the walls to reach high places?",
		"But it's difficult to learn the DOUBLE JUMP",
		"Do you know how to do such thing?"
	]
