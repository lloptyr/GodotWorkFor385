extends Area2D
@onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")
func _on_body_entered(body):
	anim_player.play("fade_out")
	PlayerData.set_wallcling(true)
	anim_player.play("tutorial")
