extends Node
class_name MovementState

var player : CharacterBody3D

var direction : Vector3

var enter_state_timestamp : float

var animation : String

var animation_done : bool

var lerp_speed := 10.0


static var moves_weight : Dictionary = {
	"idle" : 1.0,
	"halt" : 1.5,
	"run" : 2.0,
	"sprint" : 3.0,
	"jump": 10.0,
	"sprint_jump" : 11.0,
	"midair" : 15.0
}



func sort_moves_by_weight(a : String, b : String):
	if moves_weight[a] > moves_weight[b]:
		return true
	return false


func check_relevance(_input : InputPackage) -> String:
	print_debug("error, implement the check_relevance function in your state")
	return "error, implement the check_relevance function in your state"


func mark_enter_state():
	enter_state_timestamp = Time.get_unix_time_from_system()


func get_progress():
	var now = Time.get_unix_time_from_system()
	return now

func works_longer_than(time : float) -> bool:
	if get_progress() >= time:
		return true
	return false


func works_between(start : float, finish : float) -> bool:
	var progress = get_progress()
	# Alternativ fra gab: if progress >= start and progress <= finish:
	if start <= progress <= finish:
		return true
	return false


func update(input : InputPackage, delta : float):
	pass


func on_enter_state():
	pass
	
	
	
func on_exit_state():
	pass
	
