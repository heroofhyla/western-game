extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var messages = []
var state = "idle"
func _ready():
	visible = false
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	

func _process(delta):
	if Input.is_action_just_pressed("interact") and visible and state == "ready":
		next_message()
	if state == "almost_ready":
		state = "ready"
	
func next_message():
	if len(messages) == 0:
		visible = false
		get_tree().paused = false
		state = "idle"
		return
	
	$Text.text = messages.pop_front()
	
func show_messages(new_messages):
	get_tree().paused = true
	messages = new_messages.duplicate()
	next_message()
	visible = true
	state = "almost_ready"

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
