extends Area2D
var move = Vector2()
var speed = 50
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
