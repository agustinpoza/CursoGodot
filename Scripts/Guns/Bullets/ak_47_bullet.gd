extends Bullet


func _on_body_entered(body: Enemy) -> void:
	if(body.is_in_group("enemy")):
		body.get_damage(damage)
		print(damage)
		queue_free()
