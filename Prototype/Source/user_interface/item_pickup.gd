extends Control


var wallclingget="You can now cling to walls!"
var dashget="You can now dash!"

@onready var itemget: AudioStreamPlayer=get_node("itemgetsound")

func item_get(item_name):
	get_tree().paused=true
	get_node("pickupscreen").visible=true
	itemget.playing=true
	match(item_name):
		"wallcling":
			get_node("pickupscreen/item_info").text=wallclingget
			PlayerData.set_wallcling(true)
		"DashRune":
			self.item_info.text=dashget
