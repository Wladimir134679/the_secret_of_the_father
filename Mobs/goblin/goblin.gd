extends "res://Mobs/mob_obj.gd"

var SPEED = 130
#var destination = Vector2()
var target_position: Vector2 = Vector2.ZERO
var prev_pos = Vector2()
var to_target_velocity: Vector2 = Vector2()
@onready var anim: AnimatedSprite2D = $Anim
@onready var atack_zone: Area2D = $ZoneAtack

#var player
@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready():
	SPEED = 100
	auto_dead_queue = false
	#player = get_tree().root.find_child('Player', true, false)
	
#func _physics_process(delta: float) -> void:

func _process(delta):
	$DebugInfo.text = "HP: " + str(health.current) + "\nState: " + STATE_ACTION.keys()[state_action] + "\nLen: " + str(velocity.length())
	
	_find_target_atack()
	
	match state_action:
		STATE_ACTION.TARGET:
			# Если мы достигли цель, то ищем цель, если нет цели рядом, отменяем движение
			if nav.is_navigation_finished():
				cancel_movement()
			else:
				# если есть движение, то есть движение, ауф
				var next_point_pos = nav.get_next_path_position()
				velocity = global_position.direction_to(next_point_pos) * SPEED
				move_velocity()
		STATE_ACTION.ATACK:
			# процесс атаки, тут найти цель на 50% атаки и снять ХП у здания\игрока
			anim.animation = 'atack'
			
			var size = anim.sprite_frames.get_frame_count("atack")
			if anim.frame >= size - 1:
				state_action = STATE_ACTION.STAND	
			elif anim.frame >= (size - 1) / 2:
				var objs = atack_zone.get_overlapping_bodies()
				for o_enemy in objs:
					to_damage(1, o_enemy)
				#await anim.animation_finished
				
		STATE_ACTION.STAND:
			# Когда стоит без дела, искать куда идти
			_find_target()
		STATE_ACTION.DEAD:
			# тут завершаем смерть гоблина
			end_dead()
			queue_free()
	
func move_velocity():
	if velocity:
		anim.animation = 'Walk'
		prev_pos = position
		move_and_slide()
		position.x = clamp(position.x, 0, 10000)
		position.y = clamp(position.y, 0, 10000)
		
		var pos = position
		$DebugInfo.text += "\nDist_to: " + str(pos.distance_to(prev_pos))
		if pos.distance_to(prev_pos) <= 0.6:
			cancel_movement()
	
func cancel_movement():
	state_action = STATE_ACTION.STAND
	anim.animation = 'Idle'
	velocity = Vector2.ZERO
	target_position = Vector2.ZERO
	
func target_atack():
	print("Нашли цель!")
	state_action = STATE_ACTION.ATACK
	anim.animation = 'atack'

func _on_timer_navigation_timeout() -> void:
	if state_action != STATE_ACTION.TARGET:
		return
	_find_target()

func _find_target_atack() -> bool:
	var objs = atack_zone.get_overlapping_bodies()
	for o_enemy in objs:
		state_action = STATE_ACTION.ATACK
		return true
	return false
	

func _find_target():
	var objs = $FindPlayerZone.get_overlapping_bodies()
	var find_player = false
	for o_enemy_player in objs:
		state_action = STATE_ACTION.TARGET
		find_player = true
		_navigation_to(o_enemy_player.global_position)
		break
	if not find_player:
		pass
		

func _navigation_to(target_position):
	nav.target_position = target_position
	target_position = target_position

func to_damage(count, obj):
	if obj.has_method('damage'):
		obj.damage(count)

# Тут спавн выпадения предметов из гоблинов после их смерти
func end_dead():
	var preloadExplosion = preload("res://objs/explosion/explosion.tscn")
	var instExplosion = preloadExplosion.instantiate()
	instExplosion.position = position
	instExplosion.scale.x = 0.5
	instExplosion.scale.y = 0.5
	instExplosion.set_name_anim('dead')
	get_parent().add_child(instExplosion)

func _on_on_death():
	print("Гоблин умэр")
	state_action = STATE_ACTION.DEAD
	
