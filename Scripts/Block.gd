extends CharacterBody3D
class_name Block

var on_fire: bool = false
var has_player: bool = false
var fireling_child: Fireling

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func handle_body_exited(body: Node3D) -> void:
	# If the player left the block or an object on the block was on fire, set it on fire
	if((body is Player || body is Consumable) && body is not FireExstinguisher):
		# For some reason, when the game upauses, it thinks the consumable on top of it leaves
		# So now if the consumable "leaves" but isn't on fire, it won't set the block on fire
		if(body is Consumable):
			if(!(body as Consumable).on_fire):
				return
		spawn_fire(5)


# Spawn a fireling on top of the block
func spawn_fire(health) -> void:
	# Don't do it if the block is already on fire
	if(on_fire || has_player || GameMaster.fire_is_dying):
		# Why isn't on_fire tied to the player?
		# Because if the player leaves a block that is on fire
		# it may mark the block as not on fire.
		# Meaning an on fire block will have fire spawn on it. Not good.
		return
	# Set the block on fire
	on_fire = true
	# Create the fireling using its packed scene
	var fireling_scene: PackedScene = ResourceLoader.load("uid://de332samgnmvl")
	var new_fireling = fireling_scene.instantiate()
	new_fireling.health = health
	# Place it on top of the block
	new_fireling.position = Vector3(0,0.25,0)
	add_child.call_deferred(new_fireling)
	fireling_child = new_fireling
	# Update the overall fire health
	GameMaster.change_health(health)


# Put out the fire on top of it
func put_out_fire():
	# Get rid of the fireling on top of the block
	if(fireling_child != null):
		fireling_child.queue_free()
	# Can't be lit on fire for a quick second
	await get_tree().create_timer(1.0).timeout
	on_fire = false
