class_name Grass extends Node

func _ready() -> void:
	$HurtBox.damaged.connect(take_damage)

func take_damage ( _dmg : int ) -> void:
	queue_free()
