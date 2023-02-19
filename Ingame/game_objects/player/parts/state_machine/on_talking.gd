extends StateMachineState

@onready var dialog_textboxses = get_tree().get_first_node_in_group("DIALOG_TEXTBOXES")

var texts                 : Array[String]
var current_text_position : int
var talking               : bool
var end_talking_lock_time : float

func enter() -> void:
	texts = host.talking_npc.get_texts()
	current_text_position = 0
	end_talking_lock_time = -10.0
	_pass_text()

func exit() -> void:
	dialog_textboxses.stop()
	host.talking_npc = null

func step(delta : float) -> StateMachineState:
	if not is_instance_valid(host.talking_npc): return state_machine.on_ground

	_move(delta)
	
	if Input.is_action_just_pressed("pass_text"):
		_pass_text()
		
	host.move_and_slide()
	
	if talking == false:
		end_talking_lock_time -= delta
		
	if  current_text_position >= texts.size() + 1:
		return state_machine.on_ground
	
	return self

func _move(delta : float) -> void:
	var direction = -1.0
	var my_position : float = host.global_position.x
	var npc_position : float = host.talking_npc.global_position.x
	var npc_player_position : float = npc_position + host.talking_npc.player_target_relative_position.x
	print(abs(my_position - npc_player_position))
	if abs(my_position - npc_player_position) > 5.0:
		host.velocity.x = move_toward(host.velocity.x, direction * host.specs.speed, host.specs.acceleration)
	else:
		host.velocity.x = .0
		host.sprite.flip_h = true

func _pass_text() -> void:
	if talking:
		dialog_textboxses.skip()
		talking = false
		return
	if end_talking_lock_time < .0:
		if current_text_position < texts.size():
			var text = texts[current_text_position]
			dialog_textboxses.start(text)
			talking = true
		current_text_position += 1

func _text_animation_finished() -> void:
	talking = false
	end_talking_lock_time = .3

func _ready() -> void:
	dialog_textboxses.text_animation_finished.connect(_text_animation_finished)
