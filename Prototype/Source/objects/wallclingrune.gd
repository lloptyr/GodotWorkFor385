extends Area2D
@onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")
@onready var scene=get_tree().current_scene
@onready var pickup=scene.get_node("Itemgetcanvas/item_pickup")
func _on_body_entered(body):
	if(self.visible):
		pickup.item_get("wallcling")
		anim_player.play("fade_out")
		await(anim_player.animation_finished)
		queue_free()
