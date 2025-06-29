extends MovementState
class_name SprintJump

var jump_velocity := 5.5

const TRANSISTION_TIMING := 0.4167
const JUMP_TIMING := 0.1421

var jumped := false

func _ready() -> void:
	
	animation = "sprint_jump_start"

func check_relevance(_input : InputPackage):
	# wait til animation ends, then switch to "midair"
	if works_longer_than(TRANSISTION_TIMING):
		jumped = false
		return "midair"
	else:
		return "okay"
	
func update(_input : InputPackage, delta):
	if works_longer_than(JUMP_TIMING):
		if not jumped:
			jumped = true
			player.velocity.y += jump_velocity
	player.move_and_slide()
