extends Button

@export var next_scene=""


func _on_button_up():
	if FileAccess.file_exists("user://savegame.save"):
		PlayerData.load_game_state()
		next_scene=PlayerData.get_playing_scene()
		get_tree().change_scene_to_file(next_scene)
		get_tree().paused=false
