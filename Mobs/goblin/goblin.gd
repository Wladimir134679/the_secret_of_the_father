extends "res://Mobs/mob_obj.gd"

var SPEED = 130
var destination = Vector2()
var prev_pos = Vector2()
var target = null
@onready var anim: AnimatedSprite2D = $Anim
@onready var atack_zone: Area2D = $ZoneAtack

var player
@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready():
	SPEED = 100
	auto_dead_queue = false
	player = get_tree().root.find_child('Player', true, false)

func _process(delta):
	match state_action:
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
				
			
		STATE_ACTION.TARGET:
			# Движение по velocity, а оно определяется в таймере
			move_velocity()
			anim.animation = 'Walk'
		STATE_ACTION.STAND:
			# Когда стоит без дела, с шансом 10% начать двигаться к цели
			if randf() > 0.9:
				state_action = STATE_ACTION.TARGET
			anim.animation = 'Idle'
		STATE_ACTION.DEAD:
			anim.animation = 'dead'
			# тут завершаем смерть гоблина
			var size = anim.sprite_frames.get_frame_count("dead")
			if anim.frame >= size - 1:
				end_dead()
				queue_free()
	
func move_velocity():
	if velocity:
		prev_pos = position
		move_and_slide()
		position.x = clamp(position.x, 0, 10000)
		position.y = clamp(position.y, 0, 10000)
	wander()
	
func search_for_target():
	#var pl = $"../Player"
	if position.distance_to(player) < 200:
		cancel_movement()
		target = player
	else:
		if target:
			cancel_movement()
		target = null
	if target:
		set_destination(target.position)
	
func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * SPEED
	
func cancel_movement():
	state_action = STATE_ACTION.STAND
	velocity = Vector2()
	destination = Vector2()
	$Timer.start(2)
	
func target_atack():
	print("Нашли цель!")
	state_action = STATE_ACTION.ATACK
	

func wander():
	var pos = position
	if pos.distance_to(destination) <= 30:
		cancel_movement()
		target_atack()
	elif pos.distance_to(prev_pos) <= 0.6:
		cancel_movement()

func _on_timer_2_timeout() -> void:
	nav.target_position = player.global_position
	var target = nav.get_next_path_position()
	set_destination(target)


func to_damage(count, obj):
	if obj.has_method('damage'):
		obj.damage(count)

# Тут спавн выпадения предметов из гоблинов после их смерти
func end_dead():
	pass

func _on_on_death():
	print("Гоблин умэр")
	state_action = STATE_ACTION.DEAD
	anim.animation = 'dead'
	
