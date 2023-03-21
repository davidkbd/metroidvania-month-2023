extends Control
class_name SlotDataControl

signal start_pressed
signal delete_pressed

@onready var slot_name_label    : PixelTitle = $slot_name_label
@onready var datetime_label     : PixelLabel = $datetime_label
@onready var start_button       : UIButton = $start_button
@onready var delete_button      : UIButton = $delete_button

var confirm_dialog_instance_template : PackedScene = preload("res://UI/confirm_dialog/confirm_dialog.tscn")
var confirm_dialog_instance          : ConfirmDialog

var slot_name     : String
var slot_id       : String

func set_slot_name(_name : String) -> void:
	slot_name = _name.replace("_", " ").to_upper()

func set_slot_id(_id : String) -> void:
	slot_id = _id

func start_button_grab_focus() -> void:
	start_button.grab_focus()

func _on_start_button_pressed():
	start_button.disabled = true
	emit_signal("start_pressed", slot_id)

func _on_delete_button_pressed() -> void:
	get_tree().call_group("MENU_SFX", "play_button")
	confirm_dialog_instance = confirm_dialog_instance_template.instantiate()
	confirm_dialog_instance.set_texts(
			"Press the 'OK' button to delete the game or 'Keep' to keep it.",
			"OK", "Keep")
	add_child(confirm_dialog_instance)
	confirm_dialog_instance.accepted.connect(_on_delete_confirmed)

func _on_delete_confirmed() -> void:
	emit_signal("delete_pressed", slot_id)
	delete_button.disabled = true
	delete_button.focus_mode = Control.FOCUS_NONE
	datetime_label.text = ""
	start_button.grab_focus()

func _full_number(number : int, digits : int) -> String:
	var r = str(number)
	while r.length() < digits:
		r = "0" + r
	return r

func _ready() -> void:
	
	slot_name_label.text = slot_name
	var file_path : String = Directories.PROGRESS_PATH + "/game-state-" + slot_id + ".data"
	if FileAccess.file_exists(file_path):
		var date_dict = Time.get_datetime_dict_from_unix_time(FileAccess.get_modified_time(file_path))
		datetime_label.text = \
				_full_number(date_dict.year, 4) \
				+ "-" + _full_number(date_dict.month, 2) \
				+ "-" + _full_number(date_dict.day, 2) \
				+ " " + _full_number(date_dict.hour, 2) \
				+ ":" + _full_number(date_dict.minute, 2)
		delete_button.disabled = false
		delete_button.focus_mode = Control.FOCUS_ALL
	else:
		delete_button.disabled = true
		delete_button.focus_mode = Control.FOCUS_NONE
