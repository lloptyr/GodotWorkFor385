extends Area2D

@onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")
@export var score=100

func _on_body_entered(body):
	anim_player.play("fade_out")
	PlayerData.score+=score
	get_node("AudioStreamPlayer").playing=true
	await(get_node("AudioStreamPlayer").finished)
	queue_free()
