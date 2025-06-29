extends Node
class_name PlayerModel

@onready var player: CharacterBody3D = $".."
@onready var skeleton: Skeleton3D = $Armature/Skeleton3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_controller: CameraController = $"../CameraMount"


var currentMoveState : MovementState

var lerp_speed := 10.0



@onready var moves = {
	"idle" : $States/Idle,
	"run" : $States/Run,
	"sprint" : $States/Sprint,
	"jump" : $States/Jump,
	"midair" : $States/Midair,
	"halt" : $States/Halt,
	"sprint_jump" : $States/SprintJump
}


func _ready() -> void:
	currentMoveState = moves["idle"]
	for move in moves.values():
		move.player = player

	camera_controller.lerp_speed = lerp_speed
	
	


func update(input : InputPackage, delta : float):
	camera_controller.update(input.mouse_delta, input.freelook, delta)
	
	if not player.is_on_floor():
		currentMoveState = moves["jump"]
	
	var relevance = currentMoveState.check_relevance(input)
	if relevance != "okay":
		switch_to(relevance)
	print("current state: ",currentMoveState.name)
	currentMoveState.update(input, delta)
	
	input.queue_free()
	
	
func switch_to(state : String):
	currentMoveState.on_exit_state()
	currentMoveState = moves[state]
	currentMoveState.on_enter_state()
	animation_player.play(currentMoveState.animation)
	
