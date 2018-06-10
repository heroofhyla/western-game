extends StaticBody2D
# Can be broken with melee attacks.
func _ready():
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("damage_from_player"):
		if area.get_parent().has_method("alert_hit"):
			area.get_parent().alert_hit()
		queue_free()
