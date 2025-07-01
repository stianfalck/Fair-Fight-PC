extends MovementState
class_name Jump

const JUMP_TIMING := 0.12
const TRANSITION_TIMING := 0.25

var jump_velocity := 4.5

var jumped := false

func _ready() -> void:
	animation = "jump_start"
	

func check_relevance(input : InputPackage):
	if works_longer_than(TRANSITION_TIMING):
		jumped = false
		return "midair"
	else:
		return "okay"


func update(_input : InputPackage, delta ):
	if works_longer_than(JUMP_TIMING):
		if not jumped:
			player.velocity.y += jump_velocity
			jumped = true
	player.move_and_slide()
