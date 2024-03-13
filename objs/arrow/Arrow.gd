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
		self.queue_free()
