extends MovementState
class_name SprintJumpLanding
# Step 1: redefine your class name

const TRANSITION_TIMING := 0.4583

# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "sprint_jump_landing"


# Step 3: define transition logic
func check_relevance(input : InputPackage):
	if works_longer_than(TRANSITION_TIMING):
		input.actions.sort_custom(sort_moves_by_weight)
		return input.actions[0]
	else:
		return "okay"

# Step 4: decide what happens in state
func update(input : InputPackage, delta : float):
	player.velocity.y -= gravity * delta
	player.move_and_slide()


func on_enter_state():
	pass


func on_exit_state():
	pass
