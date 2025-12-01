class_name Player extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

var direction : Vector2 = Vector2.ZERO 
var cardinal_direction : Vector2 = Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

func _physics_process(delta):
	
	move_and_slide()

func set_direction() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT 
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN 
	
	cardinal_direction = new_dir
	
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
	
