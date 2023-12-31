extends Control

@onready var scene_tree=get_tree()
@onready var pause_overlay=get_node("PauseScreen")
@onready var score: Label =get_node("Score")
@onready var pause_title: Label =get_node("PauseScreen/title")
@onready var HP: Label = get_node("HP")
@onready var dungeonmusic=get_node("dungeonmusic")
@onready var cavemusic=get_node("cavemusic")

var paused=false: set=set_paused

func _ready():
	PlayerData.score_updated.connect(update_interface)
	PlayerData.player_died.connect(_on_PlayerData_player_died)
	PlayerData.player_damaged.connect(_on_PlayerData_player_damaged)
	update_interface()
	await(get_tree().create_timer(1).timeout)
	update_music()
	
func _process(delta):
	await(get_tree().create_timer(1).timeout)
	if(cavemusic.playing==false && dungeonmusic.playing==false):
		update_music()

func update_music():
	if(PlayerData.get_music()=="dungeon"):
		cavemusic.playing=false
		dungeonmusic.playing=true
	if(PlayerData.get_music()=="cave"):
		dungeonmusic.playing=false
		cavemusic.playing=true


func _on_PlayerData_player_died():
	self.paused=true
	pause_title.text="You Died"
	PlayerData.set_HP(PlayerData.get_max_HP())

func _on_PlayerData_player_damaged():
	update_interface()

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("Pause") and pause_title.text!="You Died":
		self.paused=!paused
		#this is Godot 4 specific, and is not well documented
		get_viewport().set_input_as_handled()
		
func update_interface():
	score.text="Coins: %s" % str(PlayerData.get_score())
	HP.text="HP: %s / %s" %[str(PlayerData.get_HP()), str(PlayerData.get_max_HP())]


func set_paused(val:bool):
	paused=val
	scene_tree.paused=val
	pause_overlay.visible=val

