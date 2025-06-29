extends CharacterBody3D

# Player nodes

@onready var neck: Node3D = $neck
@onready var head: Node3D = $neck/head
@onready var eyes: Node3D = $neck/head/eyes
@onready var standing_collision_shape: CollisionShape3D = $standing_collision_shape
@onready var crouching_collision_shape: CollisionShape3D = $crouching_collision_shape
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var camera_3d: Camera3D = $neck/head/eyes/Camera3D
@onready var animation_player: AnimationPlayer = $neck/head/eyes/AnimationPlayer


# Speed variables

var current_speed := 0.0
@export var walk_speed := 5.0
@export var sprint_speed := 9.0
@export var crouch_speed := 3.0


# States

var walking := false
var sprinting := false
var crouching := false
var freelooking := false
var sliding := false
var jumping := false


# Slide variables

var slide_timer := 0.0
var slide_timer_max := 1.0
var slide_vector := Vector2.ZERO
var slide_speed := 10
var slide_end_speed := 0.3



# Head bobbing vars

# how fast camera moves side to side
# speed will be added to index to determine how fast we move along the sine function
const HEAD_BOB_SPRINT_SPEED = 22.0
const HEAD_BOB_WALK_SPEED = 14.0
const HEAD_BOB_CROUCH_SPEED = 10.0

# how much camera moves side to side in meters
const HEAD_BOB_SPRINT_INTENSITY = 0.2 
const HEAD_BOB_WALK_INTENSITY = 0.1
const HEAD_BOB_CROUCH_INTENSITY = 0.05

# keep track of head bobbing sine function
var head_bob_vector = Vector2.ZERO # keeps track of x and y values / position 
var head_bob_index = 0.0 # keeps track of where we are in the sine function
var head_bob_current_intensity = 0.0


var mouse_is_visible := false

# Movement variables

@export var jump_velocity := 4.5

var last_velocity = Vector3.ZERO

var crouch_depth := 0.75

@export var player_height := 1.8

var lerp_speed := 10.0
var sprint_acceleration := 8.0
var walk_acceleration := 3.0
var maneuverability := 2.5

var freelook_tilt_amt := -4


# Input variables

@export var mouse_sens := 0.3
var direction := Vector3.ZERO



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	neck.position.y = player_height
	crouching_collision_shape.shape.height = player_height*crouch_depth
	ray_cast_3d.target_position.y = player_height
	
	
func _input(event):
	
	if Input.is_action_just_pressed("escape"):
		mouse_is_visible = !mouse_is_visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if mouse_is_visible else Input.MOUSE_MODE_CAPTURED)
		
	if mouse_is_visible:
		return
	
	# Mouse looking logic
	#if event is InputEventMouseMotion:
		#if freelooking:
			#neck.rotate_y(deg_to_rad((event.relative.x * -mouse_sens)))
			#neck.rotation.y = clamp(neck.rotation.y, deg_to_rad(-125), deg_to_rad(125))
		## Looking right and left will turn the entire character, while looking 
		## up and down will only turn the player head
		#else:
			#rotate_y(deg_to_rad(event.relative.x * -mouse_sens))
		#head.rotate_x(deg_to_rad(event.relative.y * -mouse_sens))
		#head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		
		
	

func _physics_process(delta: float) -> void:
	# Get movement input
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	
	
	# Handle movement states
	
	if is_on_floor():
		jumping = false
		freelooking = false
	
	# CROUCHING (dominant) 
	if Input.is_action_pressed("crouch") or sliding:
		current_speed = crouch_speed
		neck.position.y = lerp(neck.position.y, player_height * crouch_depth, delta*lerp_speed)
		
		standing_collision_shape.disabled = true
		crouching_collision_shape.disabled = false
		
		# Slide begin logic
		
		if sprinting && input_dir != Vector2.ZERO:
			sliding = true
			freelooking = true
			slide_timer = slide_timer_max
			slide_vector = input_dir
		
		walking = false
		sprinting = false
		crouching = true
		
	# STANDING
	# Check if something is above player before standing up. If true, player can't stand up.	
	elif not ray_cast_3d.is_colliding():
		neck.position.y = lerp(neck.position.y, player_height, delta*lerp_speed)
		standing_collision_shape.disabled = false
		crouching_collision_shape.disabled = true
		
		if Input.is_action_pressed("sprint"):
			# SPRINTING
			# gradually increase speed when initiating sprint
			if not jumping:
				current_speed = lerp(current_speed, sprint_speed, delta*(lerp_speed/sprint_acceleration))
				
				walking = false
				sprinting = true
				crouching = false
				
			
		else:
			# WALKING
			current_speed = lerp(current_speed, walk_speed, delta*(lerp_speed/walk_acceleration))
			
			walking = true
			sprinting = false
			crouching = false
			
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump and landing
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
			animation_player.play("jumping")
		if last_velocity.y < 0.0:
			animation_player.play("landing")
	
	# Handle freelooking
	
	if Input.is_action_pressed("freelook") or sliding or jumping:
		freelooking = true
		
		if sliding:
			eyes.rotation.z = lerp(eyes.rotation.z, deg_to_rad(-7.0), delta*lerp_speed)
		else:
			eyes.rotation.z = deg_to_rad(neck.rotation.y * freelook_tilt_amt)
	else:
		freelooking = false
		neck.rotation.y = lerp(neck.rotation.y, 0.0, delta*lerp_speed)
		eyes.rotation.z = lerp(eyes.rotation.z, 0.0, delta*lerp_speed)
	
	if sliding:
		slide_timer -= delta
		if slide_timer <= 0 or Input.is_action_just_released("crouch"):
			sliding = false
			freelooking = false
	
	# Handle headbob
	if sprinting:
		head_bob_current_intensity = HEAD_BOB_SPRINT_INTENSITY
		head_bob_index += HEAD_BOB_SPRINT_SPEED*delta
	elif walking:
		head_bob_current_intensity = HEAD_BOB_WALK_INTENSITY
		head_bob_index += HEAD_BOB_WALK_SPEED*delta
	elif crouching:
		head_bob_current_intensity = HEAD_BOB_CROUCH_INTENSITY
		head_bob_index += HEAD_BOB_CROUCH_SPEED*delta
		
	if is_on_floor() and !sliding and input_dir != Vector2.ZERO:
			head_bob_vector.y = sin(head_bob_index)
			head_bob_vector.x = sin(head_bob_index/2)+0.5
			
			eyes.position.y = lerp(eyes.position.y, head_bob_vector.y*(head_bob_current_intensity/2), delta*lerp_speed)
			eyes.position.x = lerp(eyes.position.x, head_bob_vector.x*head_bob_current_intensity, delta*lerp_speed)
	else:
		eyes.position.y = lerp(eyes.position.y, 0.0, delta*lerp_speed)
		eyes.position.x = lerp(eyes.position.x, 0.0, delta*lerp_speed)
	
	
	# Handle directions
	if is_on_floor():
		direction = lerp(direction, 
						(transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized(), 
						delta*lerp_speed)
	if sliding:
		direction = lerp(direction, 
					(transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized(),
					delta*lerp_speed)
		current_speed = ((slide_timer + slide_end_speed) * current_speed*2)


	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed

	else:
		velocity.x = move_toward(velocity.x, 0, delta)
		velocity.z = move_toward(velocity.z, 0, delta)
	
	last_velocity = velocity
	
	move_and_slide()
