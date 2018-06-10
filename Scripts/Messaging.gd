extends Node2D

# Handles the messaging system.

var messages = []
var state = "idle"
func _ready():
	visible = false
	pass
	

func _process(delta):
	if Input.is_action_just_pressed("continue_message") and visible and state == "ready":
		next_message()
	if state == "almost_ready":
		state = "ready"
	
func next_message():
	if len(messages) == 0:
		visible = false
		get_tree().paused = false
		state = "idle"
		return
	if len(messages) == 1:
		$MessageStatus.frame = 1
	else:
		$MessageStatus.frame = 0
	$Text.text = messages.pop_front()
	
func show_messages(new_messages):
	get_tree().paused = true
	messages = new_messages.duplicate()
	next_message()
	visible = true
	state = "almost_ready"
