extends Node2D

@export var where_scene: Node2D

func _ready():
	for obj in get_children():
		print("autoPacketObj (" + self.name + " to " + where_scene.name + "): " + obj.name)
		remove_child(obj)
		where_scene.add_child(obj)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
