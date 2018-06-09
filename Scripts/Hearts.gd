extends Node2D

var HEART = load("res://Sprites/heart.png")
var EMPTY = load("res://Sprites/empty_heart.png")
onready var PLAYER = get_node("/root/Root/Player")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _draw():
	for i in range(PLAYER.max_hp):
		draw_texture(EMPTY,Vector2(24*i,0))
	for i in range (PLAYER.hp):
		draw_texture(HEART,Vector2(24 * i,0))
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
