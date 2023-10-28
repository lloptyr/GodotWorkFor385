class_name Hitbox
extends Area2D
@export var damage := 10

func _on_area_entered(area):
	if !get_node("damagebox").disabled || !get_node("downbox").disabled :
		if area.is_in_group("hurtbox"):
			area.take_damage(damage)
