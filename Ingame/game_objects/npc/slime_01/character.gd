extends NPC

var data : Dictionary = {
	"last_talk": -1
}

func get_texts() -> Array[String]:
	$talk_sfx.play()
	data.last_talk = Time.get_unix_time_from_system()
	return [
		"Welcome little one!",
		"You came here for a reason",
		"Those filthy ones who call themselves heroes are ruinig the underground",
		"Go outside and stop them.\nBut beware...",
		"There are other upset creatures that will attack anyone they don't know",
		"Try your best and please, save us"
	]
