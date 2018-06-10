extends Area2D

# Readable sign

export (Array) var messages
onready var message_system = get_node("/root/Root/UI Layer/Messaging")

func interact():
	message_system.show_messages(messages)
	
func _ready():
	if messages == null:
		messages = []
	pass
