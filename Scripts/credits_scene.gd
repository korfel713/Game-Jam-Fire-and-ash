extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	# If the player pressed escape, bring up the quit menu
	#if(Input.is_action_just_pressed("p_menu")):
		#get_node("quit_menu").show()

	# Roll the credits
	if(get_node("Panel/Control").position.y > -950):
		get_node("Panel/Control").position.y -= 1
