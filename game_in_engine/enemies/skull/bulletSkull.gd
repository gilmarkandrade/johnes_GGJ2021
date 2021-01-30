extends Area2D
var move = Vector2()
var speed = 3
var destroy = false
var flip_h = false
var dow = false


func _process(delta):
	if destroy == false:
		$icon.flip_h = flip_h
		if !flip_h:
			move.x += speed
			
		else:
			move.x -= speed
		
	else :
		if move.y > -50 and dow == false:
			move.y -= 5
		else:
			move.y += 5
			dow = true
		if !flip_h:
			move.x -= speed
		else:
			move.x += speed
		$icon.rotation -= 01
	translate(move)




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_arrowenemie_body_entered(body):
	print(body.get_groups())
	if body.is_in_group("player") and destroy == false:
		
		queue_free()
		


func _on_arrowenemie_area_entered(area):
	
	if area.is_in_group("bullet"):
		destroy = true
		remove_from_group("bullet_enemie")
		






	
