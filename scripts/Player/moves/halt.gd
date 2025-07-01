extends MovementState
class_name Halt


func check_relevance(input : InputPackage):
	
	var new_velocity = player.velocity
	input.actions.sort_custom(sort_moves_by_weight)
	if new_velocity == Vector3.ZERO:
		return input.actions[0]
	return "okay"

func update(input : InputPackage, delta : float):	
	player.velocity = halt(input, delta)
	player.move_and_slide()
	
	
func halt(input : InputPackage, delta : float) -> Vector3:
	var new_velocity = player.velocity
	
	new_velocity.x = move_toward(new_velocity.x, 0.0, delta*40.0)
	new_velocity.z = move_toward(new_velocity.z, 0.0, delta*40.0)
	
	return new_velocity
