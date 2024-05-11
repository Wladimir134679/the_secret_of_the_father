extends "res://objs/building/building.gd"



func _on_crash_build() -> void:
	$Spawner.stop()
	$AnimatedSprite2D.animation = 'crash'
	$ProgressBar.hide()
