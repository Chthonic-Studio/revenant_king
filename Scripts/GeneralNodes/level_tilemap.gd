class_name LevelTilemap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.change_tilemap_bounds( get_tilemap_bounds() )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_tilemap_bounds() -> Array[Vector2]:
	var bounds : Array [Vector2] = []
	bounds.append(
		Vector2( get_used_rect().position * tile_set.tile_size )
	)
	bounds.append(
		Vector2( get_used_rect().end * tile_set.tile_size )
	)
	return bounds
	
