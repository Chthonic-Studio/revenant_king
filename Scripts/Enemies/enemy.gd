class_name Enemy extends CharacterBody2D

signal direction_changed ( new_direction: Vector2 )
signal enemy_damaged ( )

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
#@onready var hit_box : HitBox = $Interactions/HitBox
#@onready var hurt_box : HurtBox = $Interactions/HurtBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@export var hp: int = 5

var direction : Vector2 = Vector2.ZERO 
var cardinal_direction : Vector2 = Vector2.DOWN
var player : Player
var invulnerable : bool = false

func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func set_direction( _new_direction : Vector2 ) -> bool:
	direction == _new_direction
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
