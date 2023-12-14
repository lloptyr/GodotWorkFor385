extends Node

signal score_updated
signal player_died
signal can_save
signal player_damaged


#new setting and getting methods for Godot 4
var score=0 : set= set_score, get=get_score
var deaths=0 : set=set_deaths, get=get_deaths
var HP=5 : set=set_HP, get=get_HP
var max_HP=5: set=set_max_HP, get=get_max_HP
var has_wallcling = false : set=set_wallcling, get=get_wallcling
var allow_save=false : set=set_allow_save, get=get_allow_save
var save_path ="user://savegame.save"
var current_scene="" : set=set_current_scene, get=get_playing_scene
var music="dungeon" : set=set_music, get=get_music
var num_runes=0 : set=set_runes, get=get_runes
var exit_shop=false : set=set_exit_shop, get=get_exit_shop

func set_score(new_value:int)->void:
	score=new_value
	emit_signal("score_updated")

func get_score()->int:
	return score
	
func set_deaths(new_value:int)->void:
	deaths=new_value
	emit_signal("player_died")

func get_deaths()->int:
	return deaths

func set_HP(new_val:int):
	HP=new_val
	
func set_max_HP(new_val:int):
	max_HP=new_val

func take_damage(damage:int):
	HP-=damage
	emit_signal("player_damaged")

func get_HP()->int:
	return HP

func get_max_HP()->int:
	return max_HP

func get_wallcling()->bool:
	return has_wallcling
	
func set_wallcling(new_value:bool):
	add_rune()
	has_wallcling=new_value

func reset():
	score=0
	deaths=0
	
func set_allow_save(new_val:bool):
	allow_save=new_val
	emit_signal("can_save")

func get_allow_save()->bool:
	return allow_save
	
func get_playing_scene()-> String:
	return current_scene
	
func set_current_scene(new_val:String):
	print(new_val)
	current_scene=new_val

func reset_game_state():
	print("clearing "+ save_path)
	if FileAccess.file_exists(save_path):
		DirAccess.remove_absolute(save_path)
	
func set_music(new_val:String):
	print(new_val)
	music=new_val

func get_music()->String:
	return music
	
func set_runes(new_val:int):
	num_runes=new_val
	print(num_runes)
	
func add_rune():
	set_runes(num_runes+1)

func get_runes()->int:
	return num_runes
	
func set_exit_shop(new_val:bool):
	exit_shop=new_val

func get_exit_shop()->bool:
	return exit_shop

func save_game_state():
	emit_signal("score_updated")
	print("saving "+ save_path)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_16(score)
	file.store_16(deaths)
	file.store_8(max_HP)
	file.store_8(int(has_wallcling))
	file.store_var(current_scene)
	file.close()
	
func load_game_state():
	if FileAccess.file_exists(save_path):
		print("loading " + save_path)
		var file = FileAccess.open(save_path, FileAccess.READ)
		set_score(file.get_16())
		set_deaths(file.get_16())
		set_max_HP(file.get_8())
		set_wallcling(file.get_8())
		set_current_scene(file.get_var())
		file.close()
