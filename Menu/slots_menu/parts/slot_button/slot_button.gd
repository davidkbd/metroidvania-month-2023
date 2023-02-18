extends Button

class_name SlotButton

var slot_name : String

func menu_listener_on_open_principal_menu_pressed() -> void:
	#disabled = true
	pass

func set_slot_name(_name : String) -> void:
	slot_name = _name.replace("_", " ").to_upper()

func _ready() -> void:
	text = slot_name
