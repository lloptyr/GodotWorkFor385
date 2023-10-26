extends CharacterBody2D
class_name actor


@export var gravity = 3000.0
@export var speed: = Vector2(300, 1000)
func _physics_process(delta):
	move_and_slide()
	
	
	
