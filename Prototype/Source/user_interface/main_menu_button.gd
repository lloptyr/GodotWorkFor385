
extends Button

@export_file var next_scene_path:=""


func _on_button_up():

	get_tree().paused=false
	PlayerData.set_score(0)
	PlayerData.set_wallcling(false)
	PlayerData.set_deaths(0)
	PlayerData.set_HP(5)
	PlayerData.set_max_HP(5)
	get_tree().change_scene_to_file(next_scene_path)
