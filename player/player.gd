extends CharacterBody2D

enum STATE_PLAYER {RUN, STAND, ATACK, ROLLING_OVER, INVULNERABILITY}

const ZONE_DISTANCE = Vector2(30, 0)
var tilemap_for_camera: TileMap
@onready var anim = $AnimatedSprite2D
@onready var atack_zone: Area2D = $AtackZone

var state: STATE_PLAYER = STATE_PLAYER.STAND
var rolling_dir: Vector2
var rolling_dist: Vector2

@export var node_to_spawn: Node2D

func _ready() -> void:
	tilemap_for_camera = get_tree().root.find_child('TileMap', true, false)
	$AnimationPlayer.play("idle")

func _physics_process(delta: float) -> void:
	match state:
		STATE_PLAYER.STAND:
			anim.play("Idle")
			_update_move()
			update_atack_zone()
		STATE_PLAYER.ROLLING_OVER:
			var rolling_speed = GP.speed_move * 2
			if rolling_dir.x:
				velocity.x = rolling_dir.x * rolling_speed
			if rolling_dir.y:
				velocity.y = rolling_dir.y * rolling_speed
			var last_pos = position
			var result = move_and_slide()
			var sum_dis = position - last_pos
			rolling_dist += sum_dis
			
			if result || rolling_dist.length() > 100:
				state = STATE_PLAYER.STAND
		STATE_PLAYER.ATACK:
			update_atack_zone()
			return
		STATE_PLAYER.INVULNERABILITY:
			return
		STATE_PLAYER.RUN:
			anim.play("Walk")
			_update_move()
			update_atack_zone()
			
func _update_move():
	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")
	
	
	if Input.is_action_just_pressed("rolling_over"):
		rolling_dir = Vector2(directionX, directionY)
		state = STATE_PLAYER.ROLLING_OVER
		anim.play("Idle")
		if directionX == 1:
			$AnimationPlayer.play("rolling_over_left")
		elif directionX == -1:
			$AnimationPlayer.play("rolling_over_right")
		rolling_dist = Vector2(0, 0)
		return
	
	if !directionX && !directionY:
		state = STATE_PLAYER.STAND
		anim.play("Idle")
		return
	state = STATE_PLAYER.RUN
	anim.play("Walk")
		
	move_player(directionX, directionY)
	update_animation_player(directionX, directionY)
	move_and_slide()
	var size = size_world()
	position.x = clamp(position.x, size.position.x, size.end.x)
	position.y = clamp(position.y, size.position.y, size.end.y)
	
func move_player(directionX, directionY):
	if anim.animation == 'atack':
		return
	
	var speed = GP.speed_move * 1.5 if Input.is_action_pressed("run_move") else GP.speed_move
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
	atack_zone.rotation = angle
	# Если нажали на кнопку атаки мышь, то запусть анимацию
	# повернуть в зависимости где зона атаки
	# подождать когда закончиться анимаци и вернуть обратно стоять
	if Input.is_action_just_pressed("atack_mouse"):
		var objs = atack_zone.get_overlapping_bodies()
		$AtackAudio.play()
		for o_enemy in objs:
			to_damage(GP.damage, o_enemy)
			to_damage(GP.damage, o_enemy.get_parent())
		state = STATE_PLAYER.ATACK
		anim.play("atack")
		$AnimatedSprite2D.flip_h = atack_zone.position.x < 0
		await anim.animation_finished
		state = STATE_PLAYER.STAND
		anim.play("Idle")

func to_damage(count, obj):
	if obj.has_method('damage'):
		obj.damage(count, self)
	
func damage(d):
	if state == STATE_PLAYER.INVULNERABILITY:
		return
	$AnimationPlayer.play("invulnerability", -1, 2)
	state = STATE_PLAYER.INVULNERABILITY
	$InvulnerabilityTimer.start()
	anim.play("Idle")
	GP.health -= d
	if GP.health <= 0:
		state = STATE_PLAYER.STAND
		anim.play("Idle")
		GP.dead_to_respawn()
		if node_to_spawn:
			position = node_to_spawn.position
			if node_to_spawn.has_method("action"):
				node_to_spawn.action()
		
	
func size_world() -> Rect2i:
	var r = tilemap_for_camera.get_used_rect()
	var qs = tilemap_for_camera.rendering_quadrant_size
	return Rect2i(r.position.x * qs, r.position.y * qs, r.size.x * qs, r.size.y * qs)
	

func _on_invulnerability_timer_timeout():
	$AnimationPlayer.play("idle")
	state = STATE_PLAYER.STAND
