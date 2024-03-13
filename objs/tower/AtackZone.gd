extends Area2D


@onready var atack_zone: Area2D = $"."
@export var arrow_spawn: PackedScene

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_atack_timer_timeout() -> void:
	var enemy = get_enemy()
	if enemy:
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
	
