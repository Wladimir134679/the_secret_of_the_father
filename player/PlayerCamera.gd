extends Camera2D

@export var player: CharacterBody2D
var tilemap_for_camera: TileMap
@export var to_player: bool = true

func _ready() -> void:
	tilemap_for_camera = get_tree().root.find_child('TileMap', true, false)


func _process(delta: float) -> void:
	if to_player:
		update_camera()
		self.position = player.position

	
func update_camera():
	var size = size_world()
	var view_size = get_viewport_rect()
	self.limit_left = min(size.position.x, view_size.position.x)
	self.limit_top = min(size.position.y, view_size.position.y)
	self.limit_right = max(size.end.x, view_size.end.x)
	self.limit_bottom = max(size.end.y, view_size.end.y)

func size_world() -> Rect2i:
	var r = tilemap_for_camera.get_used_rect()
	var qs = tilemap_for_camera.rendering_quadrant_size
	return Rect2i(r.position.x * qs, r.position.y * qs, r.size.x * qs, r.size.y * qs)
