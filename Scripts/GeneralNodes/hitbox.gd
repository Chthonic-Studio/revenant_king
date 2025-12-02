class_name HitBox extends Area2D

@export var dmg : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect( AreaEntered )

func AreaEntered ( a : Area2D ) -> void:
	if a is HurtBox:
		a.take_damage(dmg)
