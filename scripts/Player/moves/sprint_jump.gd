extends MovementState
class_name SprintJump

var jump_velocity := 5.5

const TRANSISTION_TIMING := 0.4167
const JUMP_TIMING := 0.11

var jumped := false

func _ready() -> void:
	animation = "sprint_jump_start"



func check_relevance(_input : InputPackage):
	# wait til animation ends, then switch to "midair"
	if works_longer_than(TRANSISTION_TIMING):
		print("TRANSITION_TIMING reached")
		jumped = false
		return "midair"
	else:
		return "okay"
	
func update(_input : InputPackage, delta):
	print("player velocity: ", player.velocity)
	if works_longer_than(JUMP_TIMING):
		print("JUMP_TIMING reached")
		if not jumped:
			jumped = true
			player.velocity.y += jump_velocity
	player.move_and_slide()

func on_enter_state():
	print("ENTER sprint_jump, velocity.y =", player.velocity.y)
	print("[SPRINTJUMP] jumped variable in state '", self.name, "' on_enter: ", jumped)

func on_exit_state():
	print("[SPRINTJUMP] jumped variable in state '", self.name, "' on_exit: ", jumped)
