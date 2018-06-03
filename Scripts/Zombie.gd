extends KinematicBody2D
export var facing = -1
export var SPEED = 25
var velocity = Vector2(0,0)
var animations = {
	"walk": {
		-1: "WalkLeft",
		1: "WalkRight"
	}
}

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	velocity.x = facing * SPEED
	velocity = move_and_slide(velocity)
	if velocity.x == 0:
		facing *= -1
		$AnimationPlayer.play(animations["walk"][facing])
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_area_entered(area):
	if area.name == "PunchBox":
		queue_free()
