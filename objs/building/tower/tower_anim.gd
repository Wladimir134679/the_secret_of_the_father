extends AnimatedSprite2D

@onready var build = $".."
@onready var progress_bar = $"../ProgressBar"



func _process(delta: float) -> void:
	if build.health <= 0:
		progress_bar.hide()
		animation = 'destroyed'
	else:
		progress_bar.show()
		animation = 'tower'
