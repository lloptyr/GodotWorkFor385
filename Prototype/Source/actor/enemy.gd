extends "res://Source/actor/actor.gd"
@export var score=100
@onready var _animated_sprite = $AnimatedSprite2D
var health:=10

func _ready():
	velocity.x=(-speed.x)+200
	
func _physics_process(delta):
	velocity.y+=gravity*delta
	if is_on_wall():
		velocity.x*=-1.0
	if (velocity.x<0):
		_animated_sprite.flip_h=false
	if(velocity.x>0):
		_animated_sprite.flip_h=true
	move_and_slide()
	
func die():
	PlayerData.score+=score
	get_node("CollisionShape2D").disabled=true
	queue_free()

func take_damage(damage):
	health-=damage
	if health<=0:
		die()

