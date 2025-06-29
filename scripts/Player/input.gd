extends Node
class_name InputGatherer

@onready var player: CharacterBody3D = $".."

var last_velocity := Vector2.ZERO

var mouse_delta := Vector2.ZERO

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative


func gather_input() -> InputPackage:
	var new_input = InputPackage.new()
	
	if mouse_delta != Vector2.ZERO:
		new_input.mouse_delta = mouse_delta
		mouse_delta = Vector2.ZERO
	
	if Input.is_action_pressed("freelook"):
		new_input.freelook = true

	new_input.input_direction = Input.get_vector("left", "right", "forward", "backward")
	if player.is_on_floor() and new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("run")
		if Input.is_action_pressed("sprint"):
			new_input.actions.append("sprint")
	
	if Input.is_action_just_pressed("jump"):
		if new_input.actions.has("sprint"):
			new_input.actions.append("sprint_jump")
		else:
			new_input.actions.append("jump")

	
	if new_input.input_direction == Vector2.ZERO and last_velocity != Vector2.ZERO:
		new_input.actions.append("halt")
	last_velocity = new_input.input_direction


	if new_input.actions.is_empty():
		new_input.actions.append("idle")
	
	
	return new_input
