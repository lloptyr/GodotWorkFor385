extends ColorRect
@onready var npc=get_node("npclines")
@onready var player=get_node("response")
@onready var music=get_node("../../tavernmusic")
@onready var dialogue=0
var max_dialogue=9
@export_file var next_scene= ""


func _ready():
	music.playing=true
	update_dialogue()

func update_dialogue():
	match dialogue:
		0:
			npc.text="Hello, you seem new here! I'm Anna."
			player.text="Where am I?"
		1:
			npc.text="You're in a deep maze created by a vampire lord."
			player.text="Excuse me?"
		2:
			npc.text="They collect people from the nearby towns, and trap them here to feast on them later."
			player.text="That's awful"
		3:
			npc.text="You seem like the more capable type, given your sword."
			player.text="You think I can fight a vampire?"
		4:
			npc.text="No, but they do occasionally trap adventurers in here to hunt for sport."
			player.text="So you're saying I have no chance."
		5:
			npc.text="There is some small chance, but no one has ever done it."
			player.text="Go on..."
		6:
			# wallcling, dash, double jump, damage up x3, health up x2, heal x2 
			npc.text="There are 10 runes of power hidden throughout this maze. If you collect them all, you might have a chance to defeat the vampire and save us all."
			player.text="I think I already may have found one."
		7:
			npc.text="Incredible! you may be our only hope."
			player.text="That's grim."
		8:
			npc.text="Grim is our way of life here, sadly."
			player.text="Well I dont plan on staying long!"
		9:
			npc.text="That's the spirit! I'll be here if you have any more questions!"
			player.text="I'll be sure to visit you again."

func _on_response_button_up():
	dialogue+=1
	if(dialogue>max_dialogue):
		PlayerData.set_exit_shop(true)
		get_tree().change_scene_to_file(next_scene)
	update_dialogue()
