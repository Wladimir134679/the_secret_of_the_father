extends Control


var item

func _process(delta: float) -> void:
	$Sprite2D.texture = item.texture
	$number.text = str(item.count)
