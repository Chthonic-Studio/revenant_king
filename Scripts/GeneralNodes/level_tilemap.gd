class_name LevelTilemap extends TileMapLayer

func _ready() -> void:
	LevelManager.register_tilemap(self)
