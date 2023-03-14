extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	$talk_sfx.play()
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"WOAH!\nYou scared me",
		"How you find me?",
		"Please dont' say anything about me, I don't want to go outside",
		"I don't wanna die"
	]
