class_name LevelTilemap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.change_tilemap_bounds( get_tilemap_bounds() )


func get_tilemap_bounds() -> Array[Vector2]:
	var bounds : Array [Vector2] = []
	var used_rect := get_used_rect()
	var tile_size := tile_set.tile_size
	bounds.append(
		Vector2( used_rect.position * tile_size )
	)
	bounds.append(
		Vector2( used_rect.end * tile_size )
	)
	return bounds
	
