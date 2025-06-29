extends MovementState
class_name Fall

func _ready() -> void:
	animation = "midair"



func check_relevance(input : InputPackage):
	# if player is on floor, change state, else keep falling
	if player.is_on_floor():
		input.actions.sort_custom(sort_moves_by_weight)
		return input.actions[0]
	return "okay"


func update(input, delta):
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
