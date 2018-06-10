extends Area2D

var ready_to_explode = false
func _ready():
	pass

func _physics_process(delta):
	if ready_to_explode:
		var overlaps = get_overlapping_areas()
		for area in overlaps:
			if area.get_parent().is_in_group("destructable"):
				area.get_parent().queue_free()
		ready_to_explode = false
func explode():
	ready_to_explode = true
	