extends CharacterBody3D
class_name Consumable

@export var fuel: float 
@export var fuel_con_rate: float 
@export var fuel_con_tick: float 
var fuel_con_tick_tracker = 0.0;
var on_fire = false
var max_fuel: float
@export var height: float # Height of the object
var fire_child: Fireling # Fireling spawned when it's on fire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_fuel = fuel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If the consumable runs out of fuel it needs to remove itself
	if (fuel <= 0):
		# If it has a fire child, take its health away from the game master
		if(fire_child != null):
			GameMaster.change_health(-1*fire_child.health)
		queue_free()
	
	# If on fire then every fuel_con_tick the fuel will be reduced by the fuel_con_rate
	if (on_fire):
		# So long as something is on fire, the fire is not dying
		GameMaster.fire_is_dead = false
		fuel_con_tick_tracker += delta
		if (fuel_con_tick_tracker > fuel_con_tick):
			fuel -= fuel_con_rate
			fuel_con_tick_tracker = 0.0 
	
	
func touching_Fire(body: Node3D) -> void:
	# If the collisionShape detects any fire and is not on fire it then sets it on fire.
	# This functon is meant to work with the on_body_enter signal
	if(body is Player && !on_fire):
		spawn_fireling()
		on_fire = true
	# If it's a fireling, increase its health
	if(body is Fireling && !on_fire):
		spawn_fireling()
		on_fire = true
		(body as Fireling).health += max_fuel
		GameMaster.change_health(max_fuel)


func spawn_fireling():
	if(on_fire):
		return
	on_fire = true
	# Create the fireling
	var fireling_scene: PackedScene = ResourceLoader.load("uid://de332samgnmvl")
	var new_fireling = fireling_scene.instantiate()
	new_fireling.health = 2*fuel #So that the fire keeps burning if the fireling loses all health before the consumable does
	GameMaster.change_health(2*fuel)
	# Place it on top of the block
	new_fireling.position = Vector3(0,height,0)
	add_child(new_fireling)
	fire_child = new_fireling
