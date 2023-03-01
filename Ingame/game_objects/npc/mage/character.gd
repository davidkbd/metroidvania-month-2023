extends CharacterAlive

var value : int = 0

func get_texts() -> Array[String]:
	return [
		"HOLA AMIGOS",
		"Que se te acontece asdfkajsdh kajdf\njaksdfkajdfasdf\noasda dsf asdfsdfasd asdfasdf asdf asd fasdfa sdfa sdfa sdf afjadfkj",
		"HOLA AMIGOS"
	]

func pass_step() -> bool:
	return true
