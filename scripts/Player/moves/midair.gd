extends MovementState
class_name Midair

@onready var downcast: RayCast3D = $"../../Downcast"
@onready var downcast_attachment: BoneAttachment3D = $"../../Armature/Skeleton3D/DowncastAttachment"

@export var land_thresh := 1.126

func _ready() -> void:
	animation = "midair"


func check_relevance(input : InputPackage):
	# if player is below landing threshold, change to landing state depending
	# on horisontal velocity
	var floor_point = downcast.get_collision_point()
	print("distance to gnd:")
	print(downcast_attachment.global_position.distance_to(floor_point))
	if downcast_attachment.global_position.distance_to(floor_point) < land_thresh:
		var xz_vel = player.velocity
		xz_vel.y = 0.0
		if xz_vel.length_squared() >= 10:
			return "sprint_jump_landing"
		return "jump_landing"
	else:
		return "okay"


func update(input, delta):
	print("player velocity: ", player.velocity)
	player.velocity.y -= gravity * delta
	player.move_and_slide()

func on_enter_state():
	print("ENTER midair, velocity.y =", player.velocity.y)
