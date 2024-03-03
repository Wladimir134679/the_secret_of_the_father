extends Node

@export var id: int = 0
@export var title = 'item_def'
@export var description = 'Тута опИсание'
@export var count: int = 1
@export var texture: Texture2D

func pick():
	Pack.add(self)
	queue_free()
	

