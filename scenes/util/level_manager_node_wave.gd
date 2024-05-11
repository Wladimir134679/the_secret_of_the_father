extends Node2D

@export var next_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ManagerLevel.next_level_scene = next_level.resource_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
