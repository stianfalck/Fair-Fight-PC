extends Node
class_name CameraController

@onready var player: CharacterBody3D = $".."
@onready var camera_mount: CameraController = $"."
@onready var camera_pivot: Node3D = $CameraPivot


# Input variables
@export var mouse_sensitivity := 0.3

var lerp_speed := 10.0

func _ready() -> void:
	pass

func update(mouse_delta : Vector2, freelook : bool, delta : float):
	apply_mouse_input(mouse_delta, freelook, delta)


func apply_mouse_input(mouse_delta : Vector2, freelook, delta):
	if freelook:
		camera_mount.rotate_y(deg_to_rad(mouse_delta.x * -mouse_sensitivity))
		camera_mount.rotation.y = clamp(camera_mount.rotation.y, deg_to_rad(-125), deg_to_rad(125))
	else:
		camera_mount.rotation.y = lerp(camera_mount.rotation.y, 0.0, delta*lerp_speed)
	
	if player.is_on_floor() and not freelook:
		player.rotate_y(deg_to_rad(mouse_delta.x * -mouse_sensitivity))
	
	camera_pivot.rotate_x(deg_to_rad(mouse_delta.y * -mouse_sensitivity))
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-89), deg_to_rad(89))
