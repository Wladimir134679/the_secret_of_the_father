extends "res://objs/Mobs/mob_obj.gd"

const ZONE_DISTANCE_ATACK = Vector2(15, 0)
#var destination = Vector2()
var target_position: Vector2 = Vector2.ZERO
var prev_pos = Vector2()
var to_target_velocity: Vector2 = Vector2()
var is_atack_processing = false
@onready var anim: AnimatedSprite2D = $Anim
@onready var atack_zone: Area2D = $ZoneAtack
@onready var timer_atack_kd = $TimerAtackKD

#var player
@onready var nav: NavigationAgent2D = $NavigationAgent2D

@export var chance_of_coin_drop: float = 0.5
@export var drop_scene: PackedScene
@export var pathfollower: PathFollow2D

func _ready():
	auto_dead_queue = false
	
	
func on_the_invulnerability(delta):
	move_velocity()
	velocity /= 1.3
	anim.flip_h = velocity.x < 0

func on_the_patrolling(delta):
	anim.animation = 'Walk'
	if _find_target(false, false):
		return
	if not pathfollower:
		return
	$DebugInfo.text += "\nOfH: " + str(pathfollower.h_offset) + "\nOfV: " + str(pathfollower.v_offset);
	pathfollower.progress += speed * delta
	_navigation_to(pathfollower.global_position)
	_move_to_target()
	anim.flip_h = velocity.x < 0
	#position = pathfollower.position
	#anim.flip_h = pathfollower.get_h_offset() < 0

func on_the_target(delta):
	anim.flip_h = velocity.x < 0
	if _find_target_atack():
		return
	_move_to_target()

func on_the_dead(delta):
	# тут завершаем смерть гоблина
	end_dead()
	queue_free()

func on_the_stand(delta):
	anim.flip_h = velocity.x < 0
	# Когда стоит без дела, искать куда идти, если он не в стане от своей атаки
	if not is_atack_processing:
		_find_target()

func on_the_atack(delta):
	anim.flip_h = velocity.x < 0
	# процесс атаки, тут найти цель на 50% атаки и снять ХП у здания\игрока
	anim.animation = 'atack'
	
	var size = anim.sprite_frames.get_frame_count("atack")
	if anim.frame >= size - 1:
		if is_atack_processing || not _find_target_atack():
			anim.animation = 'Idle'
			state_action = STATE_ACTION.STAND
	elif anim.frame >= (size - 1) / 2 && not is_atack_processing:
		is_atack_processing = true
		timer_atack_kd.start()
		var objs = atack_zone.get_overlapping_bodies()
		for o_enemy in objs:
			to_damage(1, o_enemy)
		


func _move_to_target():
	# Если мы достигли цель, то ищем цель, если нет цели рядом, отменяем движение
	if state_action != STATE_ACTION.PATROLLING && nav.is_navigation_finished():
		cancel_movement()
	else:
		# если есть движение, то есть движение, ауф
		var next_point_pos = nav.get_next_path_position()
		velocity = global_position.direction_to(next_point_pos) * speed
		move_velocity()

func move_velocity():
	if velocity:
		anim.animation = 'Walk'
		prev_pos = position
		move_and_slide()
		position.x = clamp(position.x, -10000, 10000)
		position.y = clamp(position.y, -10000, 10000)
		
		var pos = position
		$DebugInfo.text += "\nDist_to: " + str(pos.distance_to(prev_pos))
		if state_action != STATE_ACTION.PATROLLING && pos.distance_to(prev_pos) <= 0.6:
			cancel_movement()
	
func cancel_movement():
	state_action = STATE_ACTION.STAND
	anim.animation = 'Idle'
	velocity = Vector2.ZERO
	target_position = Vector2.ZERO

func _on_timer_navigation_timeout() -> void:
	if state_action != STATE_ACTION.TARGET:
		return
	_find_target()

func _find_target_atack() -> bool:
	var objs = atack_zone.get_overlapping_bodies()
	var target_atack = get_atack_target()
	if target_atack:
		for o_enemy in objs:
			if target_atack.global_position == o_enemy.global_position:
				state_action = STATE_ACTION.ATACK
				$Atack.play()
				return true
	return false
	

func _find_target(is_cancel = true, is_global = true):
	var obj_target = get_atack_target(is_global)
	if obj_target:
		state_action = STATE_ACTION.TARGET
		_navigation_to(obj_target.global_position)
		return true
	elif is_cancel:
		cancel_movement()
	return false
		

func get_atack_target(global = true):
	var objs = $FindPlayerZone.get_overlapping_bodies()
	for o_enemy_player in objs:
		return o_enemy_player
	if not global:
		return
	var towers = get_tree().get_nodes_in_group("tower")
	var min_tower = null
	for tower in towers:
		if tower.state_build == tower.STATE_BUILD.WORK:
			var min_dist: int = 9999999999
			if min_tower != null:
				min_dist = position.distance_to(min_tower.global_position)
			var dist = position.distance_to(tower.global_position)
			if dist <= min_dist:
				min_tower = tower
	if min_tower:
		return min_tower
	return null

func _navigation_to(target_position):
	nav.target_position = target_position
	target_position = target_position

func to_damage(count, obj):
	if obj.has_method('damage'):
		obj.damage(count)
	elif obj.get_parent().has_method('damage'):
		obj.get_parent().damage(count)

# Тут спавн выпадения предметов из гоблинов после их смерти
func end_dead():
	GP.add_souls(1)
	var preloadExplosion = preload("res://objs/explosion/explosion.tscn")
	var instExplosion = preloadExplosion.instantiate()
	instExplosion.position = position
	instExplosion.scale.x = 0.5
	instExplosion.scale.y = 0.5
	instExplosion.set_name_anim('dead')
	get_parent().add_child(instExplosion)
	
	if randf() <= chance_of_coin_drop:
		var inst = drop_scene.instantiate()
		inst.position = position
		get_parent().add_child(inst)
		

func _on_on_death():
	print("Гоблин умэр")
	state_action = STATE_ACTION.DEAD
	
func _update_zone_atack_angle():
	var angle = velocity.angle()
	atack_zone.position = ZONE_DISTANCE_ATACK.rotated(angle)
	atack_zone.rotation = angle

func _on_timer_atack_kd_timeout():
	is_atack_processing = false


func _on_on_damage(who) -> void:
	if who && 'position' in who:
		_push_away(who.position)
	$AnimationPlayer.play("invulnerability", -1, 1.0 / float($InvulnerabilityTimer.wait_time))


func _push_away(pos_who):
	var angl = pos_who.angle_to_point(position)
	velocity = Vector2(400, 0).rotated(angl)

