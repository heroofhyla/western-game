extends StaticBody2D

# Gate that opens automatically when the player approaches with the key
var state = "closed"
func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player" and state == "closed" and body.has_key:
		state = "open"
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		$Sprite.frame = 1
		
