extends CharacterBody2D


const SPEED = 160.0
var tilemap_for_camera: TileMap
@onready var camera : Camera2D = $Camera2D
@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	tilemap_for_camera = get_tree().root.find_child('TileMap', true, false)

func _physics_process(delta: float) -> void:

	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")
	
	#Движение персонажа
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	#Анимация движения
	if directionX == 1:
		$AnimatedSprite2D.flip_h = false
		anim.play("Walk")
	elif directionX == -1:
		$AnimatedSprite2D.flip_h = true
		anim.play("Walk")
	elif directionY:
		anim.play("Walk")
	else:
		anim.play("Idle")

	move_and_slide()
	var size = size_world()
	position.x = clamp(position.x, size.position.x, size.end.x)
	position.y = clamp(position.y, size.position.y, size.end.y)
	update_camera()


	
func update_camera():
	var size = size_world()
	var view_size = get_viewport_rect()
	camera.limit_left = min(size.position.x, view_size.position.x)
	camera.limit_top = min(size.position.y, view_size.position.y)
	camera.limit_right = max(size.end.x, view_size.end.x)
	camera.limit_bottom = max(size.end.y, view_size.end.y)
	
func size_world() -> Rect2i:
	var r = tilemap_for_camera.get_used_rect()
	var qs = tilemap_for_camera.rendering_quadrant_size
	return Rect2i(r.position.x * qs, r.position.y * qs, r.size.x * qs, r.size.y * qs)
