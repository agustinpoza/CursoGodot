extends CharacterBody2D
@export var speed = 300
@onready var animation_player = $AnimatedSprite2D
@onready var gun = $Glock

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction*speed
	animation(direction)
	move_and_slide()


func animation(dir: Vector2):
	
	if dir == Vector2.ZERO:
		animation_player.play("idle")
	if dir == Vector2.UP:
		animation_player.play("v_walk+")
	if dir == Vector2.DOWN:
		animation_player.play("v_walk-")
	if dir == Vector2.RIGHT:
		animation_player.play("h_walk")
	if dir == Vector2.LEFT:
		animation_player.flip_h #chequear
		animation_player.play("h_walk")
		
func shoot():
	if gun.can_shoot:
		gun.start_cooldown()
		const projectile = preload("res://Scenes/bullet.tscn")
		var bullet = projectile.instantiate()
		bullet.global_position = gun.sight.global_position
		bullet.look_at(get_global_mouse_position())
		get_parent().add_child(bullet)
	
func moving_shoot():
	const projectile = preload("res://Scenes/bullet.tscn")
	var bullet = projectile.instantiate()
	bullet.global_position = gun.sight.global_position
	var original_vector = get_global_mouse_position().normalized()
	var random_offset = Vector2(randf_range(-1,1),randf_range(-1,1))
	var final_vector = original_vector * random_offset
	bullet.look_at(final_vector)
	get_parent().add_child(bullet)
	
	
