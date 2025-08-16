extends CharacterBody2D
@export var speed = 70
@onready var animation_player = $AnimatedSprite2D
@onready var inventory = $Inventory
@onready var hand = $Hand
@export var damage = 1
@export var health = 100
var enemies_in_hurtbox = []
@onready var gun_in_hand
signal game_over

func _ready() -> void:
	Global.update_player_health(health)
	gun_in_hand = inventory.get_child(0).duplicate()
	hand.add_child(gun_in_hand)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if not direction == Vector2.ZERO:
		Global.update_player_pos(global_position)
	velocity = direction*speed
	animate_direction(direction)
	guns_actions()
	if not enemies_in_hurtbox.is_empty():
		recibir_daño()
	move_and_slide()

	

func guns_actions():
	if Input.is_action_just_pressed("change_gun_1"):
		change_gun_1()
	if Input.is_action_just_pressed("change_gun_2"):
		change_gun_2()
	if Input.is_action_just_pressed("change_gun_3"):
		change_gun_3()
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("shoot") and gun_in_hand.auto:
		auto_shoot()
	

func animate_direction(dir: Vector2):
	
	if dir == Vector2.ZERO:
		animation_player.play("idle")
	if dir == Vector2.UP:
		animation_player.play("v_walk+")
	if dir == Vector2.DOWN:
		animation_player.play("v_walk-")
	if dir == Vector2.RIGHT:
		animation_player.play("h_walk+")
	if dir == Vector2.LEFT:
		animation_player.play("h_walk-")
		
func shoot():
	if not $Hand.get_children().is_empty():
		if gun_in_hand.can_shoot and gun_in_hand.ammo != 0:
			gun_in_hand.single_shoot()
		elif gun_in_hand.ammo == 0:
			gun_in_hand.empty_shoot()

func change_gun_1():
	gun_in_hand = inventory.get_child(0).duplicate()
	if not hand.get_children().is_empty():
		hand.remove_child(hand.get_child(0))
	hand.add_child(gun_in_hand)
func change_gun_2():
	gun_in_hand = inventory.get_child(1).duplicate()
	if not hand.get_children().is_empty():
		hand.remove_child(hand.get_child(0))
	hand.add_child(gun_in_hand)
func change_gun_3():
	gun_in_hand = inventory.get_child(2).duplicate()
	if not hand.get_children().is_empty():
		hand.remove_child(hand.get_child(0))
	hand.add_child(gun_in_hand)

func auto_shoot():
	if not $Hand.get_children().is_empty():
		if gun_in_hand.can_shoot and gun_in_hand.ammo != 0:
			gun_in_hand.auto_shoot()
		elif gun_in_hand.ammo == 0:
			gun_in_hand.empty_shoot()


	

func recibir_daño():
	health -= enemies_in_hurtbox.size()*damage
	Global.update_player_health(health)
	if health <= 0:
		game_over.emit()
	


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemies_in_hurtbox.append(body)


func _on_hurt_box_body_exited(body: Node2D) -> void:
	enemies_in_hurtbox.erase(body)
