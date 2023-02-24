extends Node

const U_ACTIONS          : Array[String] = ["u","u","u"]
const D_ACTIONS          : Array[String] = ["d","d","d"]
const L_ACTIONS          : Array[String] = ["l","l","l"]
const R_ACTIONS          : Array[String] = ["r","r","r"]

const JUMP_ACTIONS       : Array[String] = ["x","x","x"]
const DOUBLEJUMP_ACTIONS : Array[String] = ["x","x","x"]
const DASH_ACTIONS       : Array[String] = ["o","sq","o"]
const ATTACK_ACTIONS     : Array[String] = ["sq","o","sq"]
#A

const INTERACT_ACTIONS   : Array[String] = ["u","A","u"]
const PASS_TEXT_ACTIONS  : Array[String] = ["x","sq","O"]

const MAP_ACTIONS        : Array[String] = ["sl","sl","A"]
const MENU_ACTIONS       : Array[String] = ["st","st","st"]

var configurated_control_mode : int = 1

func get_horizontal_axis() ->        float: return Input.get_axis(L_ACTIONS[configurated_control_mode], R_ACTIONS[configurated_control_mode])
#func is_left_pressed() ->            bool:  return Input.is_action_pressed(L_ACTIONS[configurated_control_mode])
#func is_right_pressed() ->           bool:  return Input.is_action_pressed(R_ACTIONS[configurated_control_mode])
func is_up_pressed() ->              bool:  return Input.is_action_pressed(L_ACTIONS[configurated_control_mode])
func is_down_pressed() ->            bool:  return Input.is_action_pressed(R_ACTIONS[configurated_control_mode])

func is_jump_just_pressed() ->       bool:  return Input.is_action_just_pressed(JUMP_ACTIONS[configurated_control_mode])
func is_doublejump_just_pressed() -> bool:  return Input.is_action_just_pressed(DOUBLEJUMP_ACTIONS[configurated_control_mode])

func is_attack_just_pressed() ->     bool:  return Input.is_action_just_pressed(ATTACK_ACTIONS[configurated_control_mode])

func is_map_just_pressed() ->        bool:  return Input.is_action_just_pressed(MAP_ACTIONS[configurated_control_mode])
func is_menu_just_pressed() ->       bool:  return Input.is_action_just_pressed(MENU_ACTIONS[configurated_control_mode])

func is_interact_just_pressed()  ->  bool:  return Input.is_action_just_pressed(INTERACT_ACTIONS[configurated_control_mode])
func is_pass_text_just_pressed() ->  bool:  return Input.is_action_just_pressed(PASS_TEXT_ACTIONS[configurated_control_mode])

func _ready() -> void:
	add_to_group("SETTINGS_LISTENER")
