extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var SPEED = 100
export var JUMP_SPEED = 200
export var GRAVITY = 300
export var can_move = true
var input = Vector2()
var velocity = Vector2()
var up = Vector2(0,-1)
var on_floor = false
var facing = 1

var animations = {
	"stand":{
		-1: "StandLeft",
		1: "StandRight"
	},
	"punch":{
		-1:"PunchLeft",
		1: "PunchRight"
	}
}
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	input.x = 0
	input.y = 0
	
	if Input.is_action_pressed("move_left"):
		
		input.x -= 1
		if on_floor and can_move:
			facing = -1
			$AnimationPlayer.play(animations["stand"][facing])
		
	if Input.is_action_pressed("move_right"):
		input.x += 1
		if on_floor and can_move:
			facing = 1
			$AnimationPlayer.play(animations["stand"][facing])
	
	if Input.is_action_just_pressed("jump"):
		if on_floor:
			velocity.y -= JUMP_SPEED
			on_floor = false

	if Input.is_action_just_pressed("punch"):
		if can_move:
			can_move = false
			$AnimationPlayer.play(animations["punch"][facing])
			$AnimationPlayer.queue(animations["stand"][facing])
	if Input.is_action_just_released("jump"):
		if velocity.y < - 50:
			velocity.y /= 2
	
	velocity.y += GRAVITY * delta
	input = input.normalized() * SPEED
	velocity.x = input.x
	velocity = move_and_slide(velocity, up)
	
	# Working around some weirdness with the built-in is_on_floor function.
	if is_on_floor():
		on_floor = true
	
	if velocity.y > 15:
		on_floor = false
