extends Button

@export_file var next_scene_path:=""


func _on_button_up():
	
	PlayerData.set_HP(PlayerData.get_max_HP())
	PlayerData.score=0
	get_tree().paused=false
	get_tree().change_scene_to_file(next_scene_path)
