extends Button


func _on_button_up():
	get_tree().paused=false
	get_node("../../../pickupscreen").visible=false
