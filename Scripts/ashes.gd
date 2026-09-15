extends CharacterBody3D
class_name Ashes

@export var ash_sound: AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(ash_sound != null):
		ash_sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
