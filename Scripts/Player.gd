extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var MAX_WALK_SPEED = 100
export var WALK_ACCELERATION = 600
export var JUMP_SPEED = 200
export var GRAVITY = 300
var BULLET = load("res://Entities/Bullet.tscn")
var input = Vector2()
var velocity = Vector2()
var up = Vector2(0,-1)
var on_floor = false
var facing = 1
var state = "stand"
var old_facing = 1
var old_state = "stand"
var next_state = null
var i = 1
var animations = {
	"stand":{
		-1: "StandLeft",
		1: "StandRight"
	},
	"punch":{
		-1:"PunchLeft",
		1: "PunchRight"
	},
	"run":{
		-1:"RunLeft",
		1:"RunRight"
	},
	"jump":{
		-1:"JumpLeft",
		1:"JumpRight"
	},
	"shoot":{
		-1: "ShootLeft",
		1: "ShootRight"
	},
	"recoil":{
		-1: "JumpLeft",
		1: "JumpRight"
	}
}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func can_punch():
	return (state == "stand"
		or  state == "run"
		or  state == "jump")

func can_move():
	return (state == "stand"
	    or  state == "run"
		or  state == "jump"
		or  state == "punch" and not on_floor
		or  state == "shoot" and not on_floor)

func fire():
	var bullet = BULLET.instance()
	bullet.position.x = self.position.x + facing * 20
	bullet.position.y = self.position.y - 12
	bullet.DIRECTION = self.facing
	get_parent().add_child(bullet)

func _physics_process(delta):
	i += 1
	i %= 100
	input.x = 0
	input.y = 0
	old_state = state
	old_facing = facing
	if Input.is_action_pressed("move_left"):
		if can_move():
			input.x -= 1

		if on_floor and can_move():
			state = "run"
			facing = -1

	if Input.is_action_pressed("move_right"):
		if can_move():
			input.x = 1

		if on_floor and can_move():
			state = "run"
			facing = 1

	if input.x == 0 and state == "run":
		state = "stand"

	if on_floor and state == "jump":
		state = "stand"
	
	if state == "run" and not on_floor:
		state = "jump"
	
	if Input.is_action_just_pressed("jump"):
		if on_floor and can_move():
			state = "jump"
			velocity.y -= JUMP_SPEED
			on_floor = false

	if Input.is_action_just_pressed("punch"):
		if can_punch():
			next_state = old_state
			state = "punch"

	if Input.is_action_just_pressed("shoot"):
		if can_punch():
			next_state = old_state
			state = "shoot"
	
	if Input.is_action_just_released("jump"):
		if velocity.y < - 50:
			velocity.y /= 2
	
	if Input.is_action_just_pressed("ui_accept"):
		print(state + "=>" + str(next_state))
	
	velocity.y += GRAVITY * delta
	input = input.normalized()
	velocity.x += input.x * WALK_ACCELERATION * delta

	if velocity.x < -MAX_WALK_SPEED:
		velocity.x = -MAX_WALK_SPEED
	
	if velocity.x > MAX_WALK_SPEED:
		velocity.x = MAX_WALK_SPEED
	
	if state != "run" and state != "jump" and state != "recoil" and  velocity.x != 0:
		if velocity.x > 0:
			velocity.x -= WALK_ACCELERATION * delta
			if velocity.x < 0:
				velocity.x = 0
		else:
			velocity.x += WALK_ACCELERATION * delta
			if velocity.x > 0:
				velocity.x = 0
	velocity = move_and_slide(velocity, up)
	
	handle_states()


	
	# Working around some weirdness with the built-in is_on_floor function.
	if is_on_floor():
		on_floor = true
	
	if velocity.y > 15:
		on_floor = false

func handle_states():
	if $AnimationPlayer.current_animation != animations[state][facing] and next_state and state == old_state:
		state = next_state
		next_state = null

	if state != old_state or facing != old_facing:
		$AnimationPlayer.play(animations[state][facing])
		if next_state:
			$AnimationPlayer.queue(animations[next_state][facing])

func _on_ReceiveDamage_area_entered(area):
	if area.is_in_group("damage_from_enemy"):
		print("OUCH!")
		velocity.x = facing * -1 * 100
		state = "recoil"
		next_state = "stand"
		handle_states()
