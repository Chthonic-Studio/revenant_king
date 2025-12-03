extends Node

signal tilemap_bounds_changed (bounds : Array[Vector2])

var current_tilemap_bounds : Array[Vector2]
var _registered_tilemaps: Array[TileMapLayer] = []
var _recalculation_scheduled: bool = false

func register_tilemap(tilemap: TileMapLayer) -> void:
	if not tilemap in _registered_tilemaps:
		_registered_tilemaps.append(tilemap)
	
	if not _recalculation_scheduled:
		_recalculation_scheduled = true
		call_deferred("_recalculate_combined_bounds")

func _recalculate_combined_bounds() -> void:
	if _registered_tilemaps.is_empty():
		return

	var combined_rect := _registered_tilemaps[0].get_used_rect()
	if _registered_tilemaps.size() > 1:
		for i in range(1, _registered_tilemaps.size()):
			combined_rect = combined_rect.merge(_registered_tilemaps[i].get_used_rect())
	
	var tile_size: Vector2i = _registered_tilemaps[0].tile_set.tile_size
	
	var final_bounds: Array[Vector2] = [
		Vector2(combined_rect.position * tile_size), # Top-left corner
		Vector2(combined_rect.end * tile_size)        # Bottom-right corner
	]
	
	current_tilemap_bounds = final_bounds
	
	tilemap_bounds_changed.emit(final_bounds)
	
	_recalculation_scheduled = false
