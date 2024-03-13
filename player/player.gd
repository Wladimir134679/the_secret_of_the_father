extends CharacterBody2D


const ZONE_DISTANCE = Vector2(30, 0)
const SPEED = 160.0
const SPEED_RUN = 360.0
var tilemap_for_camera: TileMap
@onready var camera : Camera2D = $Camera2D
@onready var anim = $AnimatedSprite2D
@onready var atack_zone: Area2D = $AtackZone


func _ready() -> void:
	tilemap_for_camera = get_tree().root.find_child('TileMap', true, false)

func _physics_process(delta: float) -> void:

	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")
		
	move_player(directionX, directionY)
	update_animation_player(directionX, directionY)
	move_and_slide()
	var size = size_world()
	position.x = clamp(position.x, size.position.x, size.end.x)
	position.y = clamp(position.y, size.position.y, size.end.y)
	
	update_atack_zone()
	update_camera()
	
func move_player(directionX, directionY):
	var speed = SPEED_RUN if Input.is_action_pressed("run_move") else SPEED
	#Движение персонажа
	if directionX:
		velocity.x = directionX * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if directionY:
		velocity.y = directionY * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
func update_animation_player(directionX, directionY):
	# если аниация не атака, то крутим вертим и анимируем движение
	if anim.animation != 'atack':
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

func update_atack_zone():
	# если анимация атаки, значит атака ещё идёт
	if anim.animation == 'atack':
		return
	
	var mouse = get_local_mouse_position()
	var angle = mouse.angle()
	atack_zone.position = ZONE_DISTANCE.rotated(angle)
	# Если нажали на кнопку атаки мышь, то запусть анимацию
	# повернуть в зависимости где зона атаки
	# подождать когда закончиться анимаци и вернуть обратно стоять
	if Input.is_action_just_pressed("atack_mouse"):
		var objs = atack_zone.get_overlapping_bodies()
		for o_enemy in objs:
			to_damage(GP.damage, o_enemy)
			to_damage(GP.damage, o_enemy.get_parent())
		anim.play("atack")
		$AnimatedSprite2D.flip_h = atack_zone.position.x < 0
		await anim.animation_finished
		anim.play("Idle")

func to_damage(count, obj):
	if obj.has_method('damage'):
		obj.damage(count)
	
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
