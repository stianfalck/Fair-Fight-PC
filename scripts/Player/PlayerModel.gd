extends Node
class_name PlayerModel

@onready var player: CharacterBody3D = $".."
@onready var skeleton: Skeleton3D = $Armature/Skeleton3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_controller: CameraController = $"../CameraMount"

@onready var downcast: RayCast3D = $Downcast
@onready var downcast_attachment: BoneAttachment3D = $Armature/Skeleton3D/DowncastAttachment



var current_move_state : MovementState

var lerp_speed := 10.0



@onready var moves = {
	"idle" : $States/Idle,
	"run" : $States/Run,
	"sprint" : $States/Sprint,
	"jump" : $States/Jump,
	"midair" : $States/Midair,
	#"halt" : $States/Halt,
	"sprint_jump" : $States/SprintJump,
	"jump_landing" : $States/JumpLanding,
	"sprint_jump_landing" : $States/SprintJumpLanding
}


func _ready() -> void:
	for move in moves.values():
		move.player = player
	if not player.is_on_floor():
		current_move_state = moves["midair"]
	else:
		current_move_state = moves["idle"]
	camera_controller.lerp_speed = lerp_speed
	
	


func update(input : InputPackage, delta : float):
	camera_controller.update(input.mouse_delta, input.freelook, delta)
	print(current_move_state.animation)
	var relevance = current_move_state.check_relevance(input)
	if relevance != "okay":
		switch_to(relevance)
	print("current state: ",current_move_state.name)
	current_move_state.update(input, delta)
	var floor_point = downcast.get_collision_point()
	print("distance to gnd:")
	print(downcast_attachment.global_position.distance_to(floor_point))
	
	input.queue_free()
	
	
func switch_to(state : String):
	current_move_state.on_exit_state()
	current_move_state = moves[state]
	current_move_state.on_enter_state()
	current_move_state.mark_enter_state()
	animation_player.play(current_move_state.animation)
	
