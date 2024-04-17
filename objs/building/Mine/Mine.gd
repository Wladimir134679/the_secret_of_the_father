extends "res://objs/building/building.gd"

@onready var spawnG = $GoldSpawn
@onready var anim = $AnimatedSprite2D
var comG: int
@export var completed: bool = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	if comG >= 10:
		completed = true
	if completed == true:
		anim.frame = 1
		spawnG.process_mode = Node.PROCESS_MODE_INHERIT

func _input(event: InputEvent) -> void:
	if completed == false:
		if event.is_action_pressed('ui_action'):
			comG += GP.gold
			GP.gold = 0 
