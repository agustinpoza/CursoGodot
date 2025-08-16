extends Node2D

@onready var sight = $Glock/AnimatedSprite2D/Sight
var dir
@onready var animationPlayer = $Glock/AnimatedSprite2D
@onready var timer = $Timer
var can_shoot = true
var auto = false
var ammo = 999

func _physics_process(delta: float) -> void:
	var target_pos = get_global_mouse_position()
	dir = (target_pos - global_position).normalized()
	look_at(target_pos)

func single_shoot():
	can_shoot = false
	spawn_bullet()
	animationPlayer.play("single_shoot")
	ammo -= 1
	if animationPlayer.is_playing():
		await animationPlayer.animation_finished
	can_shoot = true


func empty_shoot():
	can_shoot = false
	animationPlayer.play("empty_shoot")
	if animationPlayer.is_playing():
		await animationPlayer.animation_finished
	can_shoot = true
	

func spawn_bullet():
	const projectile = preload("res://Scenes/bullet.tscn")
	var bullet = projectile.instantiate()
	bullet.global_position = sight.global_position
	bullet.look_at(get_global_mouse_position())
	get_tree().root.add_child(bullet)
