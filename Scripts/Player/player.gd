class_name Player extends CharacterBody2D

signal direction_changed ( new_direction : Vector2 )

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO 
var cardinal_direction : Vector2 = Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

func _physics_process(_delta):
	
	move_and_slide()
	
	if not LevelManager.current_tilemap_bounds.is_empty():
		global_position.x = clampf(global_position.x, LevelManager.current_tilemap_bounds[0].x, LevelManager.current_tilemap_bounds[1].x)
		global_position.y = clampf(global_position.y, LevelManager.current_tilemap_bounds[0].y, LevelManager.current_tilemap_bounds[1].y)

func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false 
		
	cardinal_direction = new_dir
	
	direction_changed.emit(new_dir)
	
	return true
	
func update_animation( state : String) -> void:
	sprite.play(state + "_" + anim_direction())
	pass

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else:
		print("Unrecognized Animation Direction for Player")
		return "down"
	
