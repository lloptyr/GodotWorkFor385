@tool
extends Area2D

@export var next_scene: PackedScene
@onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")

func _on_body_entered(body):
	teleport()

func _get_configuration_warnings():
	return "The next scene property cant be empty" if not next_scene else ""
	
func teleport():
	anim_player.play("fade_in")
	#new keyword replaces yield in Godot 4
	await(anim_player.animation_finished)
	get_tree().change_scene_to_packed(next_scene)



