extends Area2D

@onready var beetle : Beetle = get_parent()

func _on_body_entered(body : Player):
	body.damage(beetle)
	beetle.hitting_player = body
