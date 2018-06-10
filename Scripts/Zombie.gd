extends KinematicBody2D

# basic enemy that walks left and right and deals damage on contact

export var hp = 5
export var facing = -1
export var SPEED = 25
var velocity = Vector2(0,0)
export var state = "walk"
export var DROP_ENTITY_PATH = ""
export var DROP_CHANCE = 100
var DROP_ENTITY
var DROP
var animations = {
	"walk": {
		-1: "WalkLeft",
		1: "WalkRight"
	},
	"recoil": {
		-1: "RecoilLeft",
		1: "RecoilRight"
	}
}

func _ready():
	
	pass

func _physics_process(delta):
	velocity.x = facing * SPEED
	if state == "recoil":
		velocity.x *= -3
	velocity = move_and_slide(velocity)
	if velocity.x == 0 and state == "walk":
		facing *= -1
	
	if $AnimationPlayer.assigned_animation != animations[state][facing]:
		$AnimationPlayer.play(animations[state][facing])

func take_damage(area):
	hp -= 1
	print(hp)
	if hp > 0:
		facing = int(sign(position.x - area.get_parent().position.x)) * -1
		state = "recoil"
	else:
		if (randi()%100 + 1) < DROP_CHANCE:
			DROP_ENTITY = load(DROP_ENTITY_PATH)
			DROP = DROP_ENTITY.instance()
			DROP.position.x = position.x
			DROP.position.y = position.y
			get_parent().add_child(DROP)
		queue_free()
func _on_ReceiveDamage_area_entered(area):
	if area.is_in_group("damage_from_player") and state == "walk":
		print("taking damage")
		if area.get_parent().has_method("alert_hit"):
			area.get_parent().alert_hit()
		take_damage(area)
