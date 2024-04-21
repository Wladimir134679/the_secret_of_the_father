extends "res://objs/building/building.gd"

func _ready() -> void:
	super._ready()
	state_build = STATE_BUILD.WORK


func _process(delta: float) -> void:
	update_health_bar()

