extends Area2D
class_name AutoadvanceArea

enum Direction {
	UP, RIGHT, DOWN, LEFT
}

@export var fade_out_in : bool = true
@export var direction : Direction = Direction.RIGHT
@export var distance  : float     = 96.0

@onready var collider : CollisionShape2D = $collider
