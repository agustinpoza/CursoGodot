extends CharacterBody2D

class_name Enemy

@onready var speed = 50
@onready var lives = 20
@onready var animation_player = $AnimatedSprite2D
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
var target : Vector2
signal enemigo_muerto
@onready var sonido_daño: AudioStreamPlayer2D = $SonidoDaño

func _ready() -> void:
	Global.new_player_position.connect(update_target)

func _physics_process(delta: float) -> void:
	if target: 
		if not nav_agent.is_target_reached():
			var next_point = nav_agent.get_next_path_position()
			var direction = (next_point - global_position).normalized()
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
		animation_player.play("h_walk+")
	if max_dot == left_dot:
		animation_player.play("h_walk-")
		

func get_damage(damage : int):
	lives -= damage
	Global.create_particle("blood_particle", global_position)
	sonido_daño.play()
	await sonido_daño.finished
	sonido_daño.stop()
	if lives <= 0:
		enemigo_muerto.emit()
		#animation_player.play("dead")
		#await animation_player.animation_finished
		queue_free()

func update_target():
	target = Global.playerPosition


func _on_nav_timer_timeout() -> void: # Timer para no sobrecargar recalculando target
	if nav_agent.target_position != target:
		nav_agent.target_position = target
	$Timer.start()
