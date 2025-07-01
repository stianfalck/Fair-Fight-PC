extends MovementState
class_name Idle

func _ready() -> void:
	animation = "idle_1"


func check_relevance(input) -> String:
	input.actions.sort_custom(sort_moves_by_weight)
	return input.actions[0]

func on_enter_state():
	player.velocity = Vector3.ZERO
