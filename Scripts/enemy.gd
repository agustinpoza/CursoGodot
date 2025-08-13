extends CharacterBody2D

@onready var speed = 300
@onready var lives = 5
@onready var animation_player = $AnimationPlayer
var target
signal enemigo_muerto

func _physics_process(delta: float) -> void:
	if target: 
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		


func get_damage():
	lives -= 1
	if lives <= 0:
		enemigo_muerto.emit()
		animation_player.play("dead")
		await animation_player.animation_finished
		queue_free()
