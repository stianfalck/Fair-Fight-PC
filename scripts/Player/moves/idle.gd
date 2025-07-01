extends MovementState
class_name Idle

func _ready() -> void:
	animation = "idle_2"


func check_relevance(input) -> String:
	if not player.is_on_floor():
		return "midair"
	input.actions.sort_custom(sort_moves_by_weight)
	return input.actions[0]

func on_enter_state():
	player.velocity = Vector3.ZERO
