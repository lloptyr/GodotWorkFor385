extends Node

signal score_updated
signal player_died

#new setting and getting methods for Godot 4
var score=0 : set= set_score, get=get_score
var deaths=0 : set=set_deaths, get=get_deaths

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

func reset():
	score=0
	deaths=0
