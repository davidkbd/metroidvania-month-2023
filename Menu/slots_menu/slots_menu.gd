extends Control

@export var slot_data_control_template : PackedScene

@onready var slot_list    : Container       = $container/slot_list
@onready var back_button  : TextureButton   = $back_button

var slots : Array = [
		{"name": "Slot 1", "id": "slot_001"},
		{"name": "Slot 2", "id": "slot_002"},
		{"name": "Slot 3", "id": "slot_003"}
		]

#var trick : bool = false
#const trick_password = "HOLAAMIGOS"
#var trick_buffer = ""

func menu_listener_on_open_principal_menu_pressed() -> void:
	back_button.disabled = true
	
func _instance_buttons() -> void:
	for sl in slot_list.get_children():
		sl.queue_free()
	for l in slots:
		var slot_control : SlotDataControl = slot_data_control_template.instantiate()
		slot_control.set_slot_name(l.name)
		slot_control.set_slot_id(l.id)
		slot_list.add_child(slot_control)
		slot_control.start_pressed.connect(_on_slot_start_pressed)
		slot_control.delete_pressed.connect(_on_slot_delete_pressed)
		if slot_control.get_index() == 0:
			slot_control.start_button_grab_focus()


func _on_slot_start_pressed(_id : String) -> void:
	get_tree().call_group("MENU_SFX", "play_slot_start")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_game_start_requested", _id)

func _on_slot_delete_pressed(_id : String) -> void:
	get_tree().call_group("MENU_SFX", "play_button")
	DirAccess.remove_absolute(Directories.PROGRESS_PATH + "/game-state-" + _id + ".data")

func _on_back_button_pressed() -> void:
	get_tree().call_group("MENU_SFX", "play_button_back")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_principal_menu_pressed")
	
#func _input(event : InputEvent):
#	if event is InputEventKey and event.pressed:
#		var e : InputEventKey = event
#		trick_buffer += OS.get_keycode_string(e.keycode)
#		if trick_buffer.length() > 20:
#			trick_buffer = trick_buffer.substr(trick_buffer.length() - 20)
#		if trick_buffer.ends_with(trick_password):
#			trick = true
##			_instance_buttons()

func _ready() -> void:
	_instance_buttons()
