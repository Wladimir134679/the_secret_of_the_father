extends Node

@export var id: int = 0
@export var title = 'item_def'
@export var description = 'Тута опИсание'
@export var count: int = 1
@export var texture: Texture2D

func pick():
	Pack.add(self)
	queue_free()
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
