extends "res://objs/building/building.gd"

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var atack_zone: Area2D = $AtackZone
@onready var atack_timer_kd: Timer = $AtackTimer
@export var arrow_spawn: PackedScene

var kd_atack: bool = false

func _ready() -> void:
	super._ready()
	state_build = STATE_BUILD.WORK


func _process(delta: float) -> void:
	_update_anim(state_build)
	_process_atack()
	
func _process_atack():
	if state_build != STATE_BUILD.WORK:
		return
	if kd_atack:
		return
	var enemy = get_enemy()
	if enemy:
		kd_atack = true
		atack_timer_kd.start()
		shot_to(enemy)
	
func shot_to(enemy: Node2D):
	var dir = global_position.direction_to(enemy.position)
	var arrow = arrow_spawn.instantiate()
	arrow.position = global_position
	arrow.speed = 50000
	arrow.dir = dir
	get_parent().get_parent().add_child(arrow)

func get_enemy() -> Node2D:
	var objs = atack_zone.get_overlapping_bodies()
	var ret = null
	var min_dis = 999999999
	for o_enemy in objs:
		if "position" in o_enemy:
			var dis = global_position.distance_to(o_enemy.position)
			if dis < min_dis:
				min_dis = dis
				ret = o_enemy
	return ret
	 
	
func _update_anim(state):
	match state:
		STATE_BUILD.SOURCE:
			progress_bar.hide()
			anim_sprite.animation = "source"
		STATE_BUILD.CRASH:
			progress_bar.hide()
			anim_sprite.animation = "source"
		STATE_BUILD.WORK:
			progress_bar.show()
			anim_sprite.animation = 'work'


func _on_crash_build():
	var body: StaticBody2D = $StaticBody2D
	body.collision_layer = 0
	var preloadExplosion = preload("res://objs/explosion/explosion.tscn")
	var instExplosion = preloadExplosion.instantiate()
	instExplosion.position = position
	instExplosion.scale.x = 3
	instExplosion.scale.y = 3
	get_parent().add_child(instExplosion)


func _on_atack__kd_timer_timeout():
	kd_atack = false
