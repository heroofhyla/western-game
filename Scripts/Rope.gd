extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var rope_color = Color(.375,.315,.125)
var black = Color(0,0,0)
func _ready():
	set_process(true);
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _draw():
	
	draw_line(position, Vector2(position.x, -get_parent().position.y), black,4)
	draw_line(position, Vector2(position.x, -get_parent().position.y), rope_color,2)
func _process(delta):
	if get_parent().get_parent().state == "moving":
		update()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
