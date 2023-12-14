extends Node2D

func _ready():
	PlayerData.set_current_scene(get_tree().current_scene.scene_file_path)
	PlayerData.set_music("cave")
