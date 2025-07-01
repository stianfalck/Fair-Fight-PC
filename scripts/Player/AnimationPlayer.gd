extends AnimationPlayer



func _ready() -> void:
	configure_blend_times()


# Step 3: define transition logic
func configure_blend_times():
	set_blend_time("idle_2", "run", 0.5)
	set_blend_time("idle_2", "sprint", 0.5)
	set_blend_time("midair", "idle_2",  0.5)
	set_blend_time("sprint_jump_landing", "idle_2", 0.2)
	
	set_blend_time("run", "sprint", 1.0)
	set_blend_time("run", "jump_start", 0.2)
	set_blend_time("run", "midair", 0.3)
	set_blend_time("run", "idle_2", 0.5)
	set_blend_time("run", "sprint_jump_landing", 0.3)
	
	set_blend_time("sprint", "sprint_jump_start", 0.5)
	set_blend_time("sprint", "midair", 0.3)
	set_blend_time("sprint", "run", 0.5)
	set_blend_time("sprint", "idle_2", 0.5)
	set_blend_time("sprint", "sprint_jump_landing", 0.3)
	
	set_blend_time("jump_start", "midair", 0.3)
	set_blend_time("sprint_jump_start", "midair", 0.3)
	set_blend_time("midair", "sprint_jump_landing", 0.2)
	set_blend_time("midair", "hard_landing", 0.3)
	
