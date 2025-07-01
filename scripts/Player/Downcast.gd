extends RayCast3D

@onready var bone_attachment: BoneAttachment3D = $"../Armature/Skeleton3D/DowncastAttachment"
@onready var target_sphere: CSGSphere3D = $DebugSpheres/target_sphere



func _process(delta: float) -> void:
	# attach downcast and ass_sphere at bone_att_3d, which is attached at the skeleton hip
	global_position = bone_attachment.global_position
	# set target_sphere where downcast collides with.. anything below skeleton
	target_sphere.global_position = get_collision_point()
