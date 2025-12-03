class_name PlayerCamera extends Camera2D

# How to use:
# This script works automatically. It receives bounds from the LevelManager,
# applies them to the camera, and ensures its parent (the Player)
# does not move outside the camera's final, clamped view.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# This connects to the LevelManager to get the map boundaries.
	LevelManager.tilemap_bounds_changed.connect(update_limits)
	# This call ensures the limits are set when the level first loads.
	update_limits(LevelManager.current_tilemap_bounds)

# This function is called by the LevelManager and sets the camera's internal limits.
func update_limits(bounds: Array[Vector2]) -> void:
	# If the bounds array is empty, we set huge limits to effectively disable them.
	if bounds.is_empty():
		limit_left = -10000000
		limit_top = -10000000
		limit_right = 10000000
		limit_bottom = 10000000
		return
	
	# This correctly sets the camera's native boundary properties.
	# The Camera2D node will automatically handle its view based on these.
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)

# We add this function to ensure the player and camera stay in sync at the boundaries.
func _physics_process(_delta: float) -> void:
	# This is the crucial fix. We get the parent node (the Player).
	var player = get_parent() as CharacterBody2D
	
	# After the camera has been clamped by its limits, its global_position might be different
	# from the player's. This line re-aligns the player to the camera's final, correct position.
	player.global_position = self.global_position
