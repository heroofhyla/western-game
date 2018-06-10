extends Area2D

# Handles all one-time pickups
# When placing this entity, enable editable children so you can
# update the sprite.
export var unlock = "dynamite"
export(Array) var message
onready var MESSAGING = get_node("/root/Root/UI Layer/Messaging")
onready var PLAYER = get_node("/root/Root/Player")

func _ready():
	# Message has to be initialized here, not up above
	# Otherwise, every powerup shares the same array.
	if message == null:
		message = []
		
	pass

func acquire():
	PLAYER.acquire(unlock)
	if len(message) > 0:
		MESSAGING.show_messages(message)
	
	queue_free()

func _on_Powerup_body_entered(body):
	if body.name == "Player":
		acquire()
