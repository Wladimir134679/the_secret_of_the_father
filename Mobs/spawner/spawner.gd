extends Node2D

# время через которое нужно заспавнить одного моба
@export var time: float = 1
# рандомность для случайности 0 - нет её
@export var time_rnd: float = 0
# какую сцену спавнить на это точке
@export var spawn_scene: PackedScene = null
# куда её добавить - нода с цены
@export var to_node : Node2D = null

# в какой зоне спавнить, берёт shape, там в зоне радиус менять только
@onready var zone_spawn: CollisionShape2D = $ZoneSpawn/CollisionShape2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	self.start()


func _process(delta: float) -> void:
	pass
	

func _on_timer_timeout() -> void:
	self.spart_obj()
	self.start()
	
func spart_obj() -> void:
	if !to_node and !spawn_scene:
		return
	var inst = spawn_scene.instantiate()
	inst.position = get_rnd_spawn_position()
	to_node.add_child(inst)

func get_rnd_spawn_position() -> Vector2:
	var zone_s = zone_spawn.shape.get_rect().position
	var zone_e = zone_spawn.shape.get_rect().end
	var origin_s = global_position - zone_s
	var origin_e = global_position - zone_e
	
	var x = randf_range(origin_s.x, origin_e.x)
	var y = randf_range(origin_s.y, origin_e.y)
	
	return Vector2(x, y)

func start() -> void:
	var _time = time if time_rnd == 0 else time + time_rnd * randf()
	timer.start(_time)
