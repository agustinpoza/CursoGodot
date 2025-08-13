extends CharacterBody2D
@export var speed = 300
@onready var animation_player = $AnimationPlayer

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction*speed
	
	if(direction != Vector2.ZERO):
		animation_player.play("Walk")
	else:
		animation_player.play("Idle")
	
	move_and_slide()
	if (Input.is_action_just_pressed("shoot")):
		shoot()


func shoot():
	const projectile = preload("res://Scenes/bullet.tscn")
	var bullet = projectile.instantiate()
	bullet.global_position = global_position
	bullet.look_at(get_global_mouse_position())
	get_parent().add_child(bullet)
	
