extends MovementState
class_name JumpLanding


const TRANSITION_TIMING := 2.0417


func _ready() -> void:
	animation = "hard_landing"
	move_name = "jump_landing"

func check_relevance(input : InputPackage):
	if works_longer_than(TRANSITION_TIMING):
		input.actions.sort_custom(sort_moves_by_weight)
		return input.actions[0]
	else:
		return "okay"


func update(input : InputPackage, delta ):
	player.velocity.y -= gravity * delta
	player.move_and_slide()
