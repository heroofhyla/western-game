extends Area2D
export var messages = ["Hello Sign", "This is my second message"]
onready var message_system = get_node("/root/Root/UI Layer/Messaging")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func interact():
	message_system.show_messages(messages)
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
