extends Area2D
class_name bench
@onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")
@export var allow_save=false

func _on_body_entered(body):
	anim_player.play("Show_text")


func _on_body_exited(body):
	anim_player.play("Hide_text")

