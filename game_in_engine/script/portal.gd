extends Area2D



func _on_portal_body_entered(body):
	if body.is_in_group("player"):
		body.set_physics_process(false)
		get_node("../CanvasLayer/AnimationPlayer").play_backwards("motion")
		yield(get_tree().create_timer(1.2),"timeout")
		get_tree().change_scene("res://scene/main.tscn")
