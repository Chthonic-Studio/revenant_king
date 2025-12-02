class_name HurtBox extends Area2D

signal damaged (dmg:int)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage (dmg:int) -> void:
	print(dmg, " Damage taken")
	damaged.emit(dmg)
