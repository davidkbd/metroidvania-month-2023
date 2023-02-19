extends Control

@export var slot_button_template : PackedScene

@onready var slot_list   : Container       = $container/slot_list
@onready var back_button  : Button          = $back_button

#var slotss : Array = Slots.get_slots()
#var recent_passed : String = ""

var trick : bool = false
const trick_password = "HOLAAMIGOS"
var trick_buffer = ""

func menu_listener_on_open_principal_menu_pressed() -> void:
	back_button.disabled = true
	
#func _check_recent_passed() -> void:
#	var recent_file = FileAccess.open(Directories.RECENT_PASSED_PATH, FileAccess.READ)
#	if recent_file:
#		recent_passed = recent_file.get_as_text()

#func _instance_buttons() -> void:
#	for b in slot_list.get_children():
#		b.queue_free()
#	var unlock : bool = true
#	var button_count : int = 0
#	var previous_name = "NONEEEEEEEEEEEEE"
#	for l in slots:
#		var button : slotButton = slot_button_template.instantiate()
#		button.set_slot_name(l.name)
#		button.set_locked(!unlock)
#		button.set_recent_unlock(recent_passed == previous_name)
#		slot_list.add_child(button)
#		button.pressed.connect(_on_slot_button_pressed.bind(button))
#		if unlock:
#			button.grab_focus()
#		unlock = (button.star_count > 0) or trick
#		button_count += 1
#		previous_name = l.name
#
#	if button_count < 1: back_button.grab_focus()
#
#func _on_slot_button_pressed(button : Button) -> void:
#	DirAccess.remove_absolute(Directories.RECENT_PASSED_PATH)
#	get_tree().call_group("MENU_SFX", "play_slot_start")
#	get_tree().call_group("MENU_LISTENER", "menu_listener_on_game_start_requested", slots[button.get_index()].name)

func _on_back_button_pressed():
	get_tree().call_group("MENU_SFX", "play_button_back")
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_open_principal_menu_pressed")

func _input(event : InputEvent):
	if event is InputEventKey and event.pressed:
		var e : InputEventKey = event
		trick_buffer += OS.get_keycode_string(e.keycode)
		if trick_buffer.length() > 20:
			trick_buffer = trick_buffer.substr(trick_buffer.length() - 20)
		if trick_buffer.ends_with(trick_password):
			trick = true
#			_instance_buttons()

func _ready() -> void:
#	_check_recent_passed()
#	_instance_buttons()
	get_tree().call_group("MENU_LISTENER", "menu_listener_on_game_start_requested", "slot_001")
