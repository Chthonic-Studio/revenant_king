class_name HurtBox extends Area2D

signal damaged (dmg:int)

func _ready() -> void:
	pass # Replace with function body.

func take_damage (dmg:int) -> void:
	print(dmg, " Damage taken")
	damaged.emit(dmg)
