extends MovementState
class_name NewMove
# Step 1: redefine your class name


# Step 2: redefine your overriden parameters
func _ready() -> void:
	animation = "animation_name"


# Step 3: define transition logic
func check_relevance(input : InputPackage):
	pass

# Step 4: decide what happens in state
func update(input : InputPackage, delta : float):
	pass


func on_enter_state():
	pass


func on_exit_state():
	pass
