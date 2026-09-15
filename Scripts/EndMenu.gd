extends Panel

@export var end_text: Label
signal pause()
signal end_game(process_mode: int)
@export var current_scene: String
@export var next_scene: String
@export var next_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func end(won: bool):
	if(won):
		end_text.text = "You win"
		next_button.text = "Next Level"
	else:
		end_text.text = "You lost"
		next_button.hide()
	end_game.emit(4)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.visible = true

func quit():
	pause.emit()

func restart():
	GameMaster.set_up()
	get_tree().change_scene_to_file(current_scene)
	
func credits():
	GameMaster.set_up()
	get_tree().change_scene_to_file(next_scene)
