extends "res://Source/actor/actor.gd"
@export var score=100

func _ready():
	velocity.x=-speed.x
	
func _on_stompdetector_body_entered(body):
	if body.global_position.y > get_node("stompdetector").global_position.y:
		return
	die()
	

func _physics_process(delta):
	velocity.y+=gravity*delta
	if is_on_wall():
		velocity.x*=-1.0
	move_and_slide()
	
func die():
	PlayerData.score+=score
	get_node("CollisionShape2D").disabled=true
	queue_free()
	
