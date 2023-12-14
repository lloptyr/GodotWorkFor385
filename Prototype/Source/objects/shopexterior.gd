extends Area2D
@onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")

var can_enter=false
@export_file var next_scene= ""

func _ready():
	match PlayerData.get_runes():
		1:
			next_scene="res://Source/levels/shopinterior.tscn"
			
	

func _process(delta):
	if(can_enter&&Input.is_action_just_pressed("interact")&&PlayerData.get_runes()>=1):
		get_tree().change_scene_to_file(next_scene)
	
func _on_body_entered(body):
	anim_player.play("show_text")
	can_enter=true
	


func _on_body_exited(body):
	anim_player.play("hide_text")
	can_enter=false

