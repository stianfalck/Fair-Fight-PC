extends CharacterBody3D


@onready var input_gatherer = $Input as InputGatherer
@onready var model = $PlayerModel as PlayerModel
@onready var player_visuals: Node3D = $Visuals
@onready var camera_mount: CameraController = $CameraMount



var lerp_speed = 10.0



func _ready() -> void:
	player_visuals.accept_skeleton(model.skeleton)



func _physics_process(delta):
	var input = input_gatherer.gather_input()
	model.update(input, delta)
	
	
	# Visuals -> follow parent transformations
