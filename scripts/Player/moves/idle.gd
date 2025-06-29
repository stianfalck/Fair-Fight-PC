extends MovementState
class_name Idle

func _ready() -> void:
	animation = "idle_1"


func check_relevance(input) -> String:
	#if abs(player.velocity.x) > 0 or abs(player.velocity.z) > 0:
		#return "halt"
	input.actions.sort_custom(sort_moves_by_weight)
	return input.actions[0]

func on_enter_state():
	if abs(player.velocity.x) == 0 and abs(player.velocity.z) == 0:
		player.velocity = Vector3.ZERO
