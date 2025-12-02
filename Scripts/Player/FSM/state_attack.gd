class_name State_Attack extends State

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"

@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var attack_stream_player : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hit_box : HitBox = $"../../Interactions/HitBox"

@export_category("Attack Variables")
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@export_category("Audio")
@export var slash_sound : AudioStream

var attacking : bool = false

func enter() -> void:
	player.update_animation("slash")
	
	sprite.animation_finished.connect( end_attack )
	attacking = true
	
	# Delay timer so damage coincides with animation
	await get_tree().create_timer( 0.15 ).timeout
	attack_stream_player.stream = slash_sound
	attack_stream_player.pitch_scale = randf_range(0.9, 1.1)
	attack_stream_player.play()
	hit_box.monitoring = true

func exit() -> void:
	sprite.animation_finished.disconnect( end_attack )
	attack_stream_player.stream = null
	end_attack()
	hit_box.monitoring = false
	pass

func process( _delta: float ) -> State :
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null

func physics( _delta: float ) -> State:
	return null
	
func handle_input ( _event: InputEvent ) -> State:
	return null

func end_attack (  ) -> void:
	attacking = false
