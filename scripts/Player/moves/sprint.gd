extends MovementState
class_name Sprint

# General movement variables

const SPEED = 10.0


func _ready() -> void:
	animation = "sprint"


func check_relevance(input : InputPackage):
	input.actions.sort_custom(sort_moves_by_weight)
	if not input.actions[0] == "sprint":
		return input.actions[0]
	return "okay"
	


func update(input : InputPackage, delta : float):	
	player.velocity = velocity_by_input(input, delta)
	player.move_and_slide()
	
	
func velocity_by_input(input : InputPackage, delta : float) -> Vector3:
	var new_velocity = player.velocity
	

	var direction = (player.transform.basis * Vector3(input.input_direction.x, 
						0.0, input.input_direction.y)).normalized()
	
	
	var target_velocity_x = direction.x * SPEED
	var target_velocity_z = direction.z * SPEED
	
	new_velocity.x = lerp(new_velocity.x, target_velocity_x, delta*lerp_speed)
	new_velocity.z = lerp(new_velocity.z, target_velocity_z, delta*lerp_speed)
	
	return new_velocity
