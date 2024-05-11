extends Node2D

@export var max: int = 3
@export var current: int = 3
@export var hide_null: bool = false

@onready var sprite: AnimatedSprite2D = $SpriteShow

func minus(value: int) -> void:
	current -= value
	update_sprite()
	
func update_new_value(max_new, current_new):
	max = max_new
	current = current_new
	update_sprite()

func _process(delta: float) -> void:
	update_sprite()

func update_sprite() -> void:
	if hide_null:
		sprite.visible = current >= 0
	var size = sprite.sprite_frames.get_frame_count('Heart') - 1
	sprite.frame = size * float(current / float(max))
