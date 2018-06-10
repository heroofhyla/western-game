extends KinematicBody2D

# basic enemy that walks left and right and deals damage on contact

export var facing = -1
export var SPEED = 25
var velocity = Vector2(0,0)
var animations = {
	"walk": {
		-1: "WalkLeft",
		1: "WalkRight"
	}
}

func _ready():
	pass

func _physics_process(delta):
	velocity.x = facing * SPEED
	velocity = move_and_slide(velocity)
	if velocity.x == 0:
		facing *= -1
		
	
	if $AnimationPlayer.assigned_animation != animations["walk"][facing]:
		$AnimationPlayer.play(animations["walk"][facing])

func _on_ReceiveDamage_area_entered(area):
	if area.is_in_group("damage_from_player"):
		if area.get_parent().has_method("alert_hit"):
			area.get_parent().alert_hit()
		queue_free()
