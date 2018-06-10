extends Node2D

# Draws a rope up from its own position to the position of its
# parent node.
var rope_color = Color(.375,.315,.125)
var black = Color(0,0,0)
func _ready():
	set_process(true);
	pass

func _draw():
	
	draw_line(position, Vector2(position.x, -get_parent().position.y), black,4)
	draw_line(position, Vector2(position.x, -get_parent().position.y), rope_color,2)
func _process(delta):
	if get_parent().get_parent().state == "moving":
		update()
