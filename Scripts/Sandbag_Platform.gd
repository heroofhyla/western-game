extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var distance = 72
export var move_speed = 100
var state = "full"
onready var initial_height = $Wood_Platform.position.y
onready var target_height = $Wood_Platform.position.y + distance
var travel_distance = Vector2()
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
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
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_ReceiveDamage_area_entered(area):
	if area.is_in_group("bullets"):
		if state == "full":
			state = "moving"
			$Wood_Platform/CollisionShape2D.disabled = true
		if area.get_parent().has_method("alert_hit"):
			area.get_parent().alert_hit()
