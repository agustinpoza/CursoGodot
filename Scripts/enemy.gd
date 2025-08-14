extends CharacterBody2D

@onready var speed = 300
@onready var lives = 5
@onready var animation_player = $AnimatedSprite2D
var target
signal enemigo_muerto

func _physics_process(delta: float) -> void:
	if target: 
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		animation(direction)
		move_and_slide()
		


func animation(dir: Vector2):
	var up_dot = dir.dot(Vector2.UP)
	var down_dot = dir.dot(Vector2.DOWN)
	var left_dot = dir.dot(Vector2.LEFT)
	var right_dot = dir.dot(Vector2.RIGHT)
	var max_dot = max(up_dot, down_dot, left_dot, right_dot)
	
	
	if max_dot == 0:
		animation_player.play("idle")
	if max_dot == up_dot:
		animation_player.play("v_walk+")
	if max_dot == down_dot:
		animation_player.play("v_walk-")
	if max_dot == right_dot:
		animation_player.play("h_walk")
	if max_dot == left_dot:
		animation_player.flip_h #chequear
		animation_player.play("h_walk")
		

func get_damage():
	lives -= 1
	if lives <= 0:
		enemigo_muerto.emit()
		animation_player.play("dead")
		await animation_player.animation_finished
		queue_free()
