extends CharacterBody2D


@export var speed: float = 50
@export var damage: int = 1
@export var dir: Vector2 = Vector2(1, 0.5):
	set (value):
		dir = value
		rotation = value.angle()


func _physics_process(delta: float) -> void:
	velocity = dir * speed * delta
	rotation = dir.angle()

	var collision = move_and_slide()
	
	if collision:
		var objs = $Area2D.get_overlapping_bodies()
		for o_enemy in objs:
			to_damage(GP.damage, o_enemy)
			to_damage(GP.damage, o_enemy.get_parent())
			
		if objs:
			self.queue_free()

func to_damage(count, obj):
	if obj.has_method('damage'):
		obj.damage(count)
