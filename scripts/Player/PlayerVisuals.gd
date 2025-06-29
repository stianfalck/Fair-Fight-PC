extends Node3D

@onready var beta_surface: MeshInstance3D = $Beta_Surface
@onready var beta_joints: MeshInstance3D = $Beta_Joints




func accept_skeleton(skeleton : Skeleton3D):
	beta_surface.skeleton = skeleton.get_path()
	beta_joints.skeleton = skeleton.get_path()
