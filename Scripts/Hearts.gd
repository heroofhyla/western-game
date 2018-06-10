extends Node2D

# Draws the player's health on the HUD
var HEART = load("res://Sprites/heart.png")
var EMPTY = load("res://Sprites/empty_heart.png")
onready var PLAYER = get_node("/root/Root/Player")

func _ready():
	pass

func _draw():
	for i in range(PLAYER.max_hp):
		draw_texture(EMPTY,Vector2(24*i,0))
	for i in range (PLAYER.hp):
		draw_texture(HEART,Vector2(24 * i,0))