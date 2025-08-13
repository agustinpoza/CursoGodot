extends Node2D

@onready var sight = $Glock/Area2D/Glock/Sight
var dir

func _physics_process(delta: float) -> void:
	var target_pos = get_global_mouse_position()
	dir = target_pos.normalized()
	look_at(target_pos)
	if dir.x < 0:
		$Glock/Area2D/Glock.flip_v = true
		print(dir) 
	else:
		$Glock/Area2D/Glock.flip_v = false
