extends Node2D

# Sandbag/Platform system. When the sandbag is shot, the sandbag
# ascends and the platform ascends by the amount in $distance. 
# The root node of the system should be at ceiling height so 
# that the ropes are the right length.
export var distance = 72
export var move_speed = 100
var state = "full"
onready var initial_height = $Wood_Platform.position.y
onready var target_height = $Wood_Platform.position.y + distance
var travel_distance = Vector2()
func _ready():
	pass

func _physics_process(delta):
	if state == "moving":
		travel_distance = Vector2(0, min(move_speed * delta, target_height - $Wood_Platform.position.y))
		if travel_distance.y > 0:
			$Wood_Platform.move_and_collide(travel_distance)
			$Sandbag.move_and_collide(-travel_distance)
		else:
			$Wood_Platform/CollisionShape2D.disabled = false
			state = "done"

func _on_ReceiveDamage_area_entered(area):
	if area.is_in_group("bullets"):
		if state == "full":
			state = "moving"
			$Wood_Platform/CollisionShape2D.disabled = true
		if area.get_parent().has_method("alert_hit"):
			area.get_parent().alert_hit()
