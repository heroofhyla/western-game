extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("damage_from_player"):
		if area.get_parent().has_method("alert_hit"):
			area.get_parent().alert_hit()
		queue_free()
