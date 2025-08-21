extends Area2D
class_name Bullet
@export var velocity = 500
@export var max_distance = 1000
@export var damage = 5
@onready var spawn_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * velocity * delta
	spawn_distance += velocity * delta
	
	if spawn_distance >= max_distance:
		queue_free()
	

func _on_body_entered(body: Enemy) -> void:
	if(body.is_in_group("enemy")):
		body.get_damage(damage)
		print(damage)
		queue_free()
