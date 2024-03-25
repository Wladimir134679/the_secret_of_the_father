extends "res://Mobs/mob_obj.gd"


var stands = true
var SPEED = 130
var destination = Vector2()
var prev_pos = Vector2()
var target = null
@onready var anim: AnimatedSprite2D = $Anim

var player
@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready():
	SPEED = 100
	player = get_tree().root.find_child('Player', true, false)

func _process(delta):
	if velocity:
		prev_pos = position
		move_and_slide()
		position.x = clamp(position.x, 0, 10000)
		position.y = clamp(position.y, 0, 10000)
	wander()
	#search_for_target()
	
func search_for_target():
	var pl = $"../Player"
	if position.distance_to(pl.position) < 200:
		cancel_movement()
		target = pl
	else:
		if target:
			cancel_movement()
		target = null
	if target:
		set_destination(target.position)
	
func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * SPEED
	stands = false
	
func cancel_movement():
	velocity = Vector2()
	destination = Vector2()
	$Timer.start(2)

func wander():
	var pos = position
	if stands:
		randomize()
		
		var x = int(randf_range(pos.x - 150, pos.x + 150))
		var y = int(randf_range(pos.y - 150, pos.y + 150))
		
		x = clamp(x, 0, 10000)
		y = clamp(y, 0, 10000)
		
		set_destination(Vector2(x, y))
	elif velocity != Vector2():
		if pos.distance_to(destination) <= SPEED:
			cancel_movement()
		elif pos.distance_to(prev_pos) <= 0.6:
			cancel_movement()

func _on_timer_timeout():
	stands = true


func _on_timer_2_timeout() -> void:
	nav.target_position = player.global_position
	var target = nav.get_next_path_position()
	set_destination(target)
