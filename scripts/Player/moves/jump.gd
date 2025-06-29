extends MovementState
class_name Jump

var jump_velocity := 4.5

func _ready() -> void:
	animation = "jump_start"

func check_relevance(input : InputPackage):
	if player.velocity.y <= 0:
		return "midair"
	return "okay"


func update(input, delta):
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()


func on_enter_state():
	player.velocity.y += jump_velocity
