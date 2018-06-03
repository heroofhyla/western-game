extends KinematicBody2D

export var DIRECTION = 1
export var SPEED = Vector2(400, 0)
export var vel = Vector2()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func alert_hit():
	queue_free()

func _physics_process(delta):
	if $Sprite.scale.x != DIRECTION:
		$Sprite.scale.x = DIRECTION
	vel = move_and_collide(SPEED * DIRECTION * delta)
	if vel:
		queue_free()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
