extends Node2D
class_name BridgePodridoSpawner

@export var bridge_podrido_template : PackedScene

var instance : BridgePodrido

func activate(_data : Dictionary) -> void:
	if not ProgressManager.game_state.bundle.bridge_podrido.destroyed:
		instance = bridge_podrido_template.instantiate()
		add_child(instance)

func deactivate() -> void:
	if is_instance_valid(instance):
		if instance.destroyed:
			ProgressManager.game_state.bundle.bridge_podrido.destroyed = true
		instance.queue_free()
