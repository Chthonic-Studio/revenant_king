class_name LevelTilemap extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Instead of calculating bounds itself, it just registers with the LevelManager.
	# The manager will then handle the logic of calculating the combined bounds.
	LevelManager.register_tilemap(self)
