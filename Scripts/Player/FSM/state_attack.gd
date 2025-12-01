class_name State_Attack extends State

@onready var walk : State = $"../Walk"
@onready var idle : State = $"../Idle"
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"

@export_category("Attack Variables")
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@export_category("Audio")
@onready var attack_stream_player : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@export var slash_sound : AudioStream

var attacking : bool = false

func enter() -> void:
	player.update_animation("slash")
	attack_stream_player.stream = slash_sound
	attack_stream_player.pitch_scale = randf_range(0.9, 1.1)
	attack_stream_player.play()
	sprite.animation_finished.connect( end_attack )
	attacking = true

func exit() -> void:
	sprite.animation_finished.disconnect( end_attack )
	attack_stream_player.stream = null
	end_attack()
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
