extends KinematicBody2D

# Player projectile
export var DIRECTION = 1
export var SPEED = Vector2(400, 0)
export var vel = Vector2()

func _ready():
	pass


func alert_hit():
	queue_free()

func _physics_process(delta):
	if $Sprite.scale.x != DIRECTION:
		$Sprite.scale.x = DIRECTION
	vel = move_and_collide(SPEED * DIRECTION * delta)
	if vel:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
