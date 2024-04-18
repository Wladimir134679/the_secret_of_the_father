extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var animation_name: String = 'explosion'

func _ready() -> void:
	anim.animation = animation_name


func _process(delta: float) -> void:
	if anim.frame >= anim.sprite_frames.get_frame_count(anim.animation) - 1:
		queue_free()

func set_name_anim(anim_name):
	self.animation_name = anim_name
