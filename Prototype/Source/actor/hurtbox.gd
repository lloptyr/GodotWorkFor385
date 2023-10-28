class_name Hurtbox
extends Area2D
func take_damage(damage):
	if owner.has_method("take_damage"):
		owner.take_damage(damage)

