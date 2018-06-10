extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ready_to_explode = false
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	if ready_to_explode:
		print("ready to explode.")
		var overlaps = get_overlapping_areas()
		print(overlaps)
		for area in overlaps:
			print("checking " + area.name)
			if area.get_parent().is_in_group("destructable"):
				area.get_parent().queue_free()
		ready_to_explode = false
func explode():
	position=position
	ready_to_explode = true
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
