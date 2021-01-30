extends Area2D
var move = Vector2()
var speed = 10
var destroy = false
var flip_h = false



func _process(delta):
	if !flip_h:
		move.x += speed
	else:
		move.x -= speed
	translate(move)




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_body_entered(body):
	if body.is_in_group("enemie") :
		yield(get_tree().create_timer(0.5),"timeout")
		queue_free()
