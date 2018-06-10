extends Area2D

export var unlock = "dynamite"
export(Array) var message
onready var MESSAGING = get_node("/root/Root/UI Layer/Messaging")
onready var PLAYER = get_node("/root/Root/Player")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if message == null:
		message = []
		
	print("Initializing powerup " + name)
	print("Messages: " + str(message))
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func acquire():
	PLAYER.acquire(unlock)
	MESSAGING.show_messages(message)
	
	queue_free()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Powerup_body_entered(body):
	if body.name == "Player":
		acquire()