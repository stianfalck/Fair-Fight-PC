extends AnimationPlayer



func _ready() -> void:
	configure_blend_times()


# Step 3: define transition logic
func configure_blend_times():
	set_blend_time("idle_1", "run", 0.5)
	set_blend_time("idle_1", "sprint", 0.5)
	set_blend_time("idle_1", "midair", 0.5)
	
	set_blend_time("run", "sprint", 0.5)
	set_blend_time("run", "jump_start", 0.5)
	set_blend_time("run", "midair", 0.3)
	set_blend_time("run", "idle_1", 0.5)
	

	
	set_blend_time("sprint", "sprint_jump_start", 0.5)
	set_blend_time("sprint", "midair", 0.3)
	set_blend_time("sprint", "run", 0.5)
	set_blend_time("sprint", "idle", 0.5)
	
	set_blend_time("jump_start", "midair", 0.3)
	set_blend_time("sprint_jump_start", "midair", 0.3)


	
