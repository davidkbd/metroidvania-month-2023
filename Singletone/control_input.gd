extends Node
class_name ControlInput

const U_ACTIONS          : Array[String] = ["u"]
const D_ACTIONS          : Array[String] = ["d"]
const L_ACTIONS          : Array[String] = ["l"]
const R_ACTIONS          : Array[String] = ["r"]

const JUMP_ACTIONS       : Array[String] = ["x"]
const DOUBLEJUMP_ACTIONS : Array[String] = ["x"]
const DASH_ACTIONS       : Array[String] = ["o"]
const ATTACK_ACTIONS     : Array[String] = ["sq"]
#A

const INTERACT_ACTIONS   : Array[String] = ["u"]
const PASS_TEXT_ACTIONS  : Array[String] = ["x"]

const MAP_ACTIONS        : Array[String] = ["sl"]
const MENU_ACTIONS       : Array[String] = ["st"]

const CONFIGURATED_CONTROL_MODE : int = 0

static func get_horizontal_axis() ->        float: return Input.get_axis(L_ACTIONS[CONFIGURATED_CONTROL_MODE], R_ACTIONS[CONFIGURATED_CONTROL_MODE])
#static func is_left_pressed() ->            bool:  return Input.is_action_pressed(L_ACTIONS[CONFIGURATED_CONTROL_MODE])
#static func is_right_pressed() ->           bool:  return Input.is_action_pressed(R_ACTIONS[CONFIGURATED_CONTROL_MODE])
static func is_up_pressed() ->              bool:  return Input.is_action_pressed(L_ACTIONS[CONFIGURATED_CONTROL_MODE])
static func is_down_pressed() ->            bool:  return Input.is_action_pressed(R_ACTIONS[CONFIGURATED_CONTROL_MODE])

static func is_jump_just_pressed() ->       bool:  return Input.is_action_just_pressed(JUMP_ACTIONS[CONFIGURATED_CONTROL_MODE])
static func is_doublejump_just_pressed() -> bool:  return Input.is_action_just_pressed(DOUBLEJUMP_ACTIONS[CONFIGURATED_CONTROL_MODE])

static func is_map_just_pressed() ->        bool:  return Input.is_action_just_pressed(MAP_ACTIONS[CONFIGURATED_CONTROL_MODE])
static func is_menu_just_pressed() ->       bool:  return Input.is_action_just_pressed(MENU_ACTIONS[CONFIGURATED_CONTROL_MODE])

static func is_interact_just_pressed()  ->  bool:  return Input.is_action_just_pressed(INTERACT_ACTIONS[CONFIGURATED_CONTROL_MODE])
static func is_pass_text_just_pressed() ->  bool:  return Input.is_action_just_pressed(PASS_TEXT_ACTIONS[CONFIGURATED_CONTROL_MODE])
