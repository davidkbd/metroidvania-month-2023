extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"You know you can do the super attack by concentrating your attack?",
		"The range is higher"
	]
