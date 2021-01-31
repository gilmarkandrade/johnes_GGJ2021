extends Area2D
var move = Vector2()
var speed = 0.5
var destroy = false
var flip_h = false
var dow = false


func _process(delta):
	if destroy == false:
		$icon.flip_h = !flip_h
		if !flip_h:
			move.x += speed
			if move.y > -3 and dow == false:
				move.y -= 0.3
			else: 
				dow = true
				move.y += 0.3
		else:
			move.x -= speed
			if move.y > -3 and dow == false:
				move.y -= 0.3
			else: 
				dow = true
				move.y += 0.3
			
	translate(move)




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_arrowenemie_body_entered(body):
	
	if body.is_in_group("player") and destroy == false:
		
		queue_free()
		


func _on_arrowenemie_area_entered(area):
	
	if area.is_in_group("bullet"):
		destroy = true
		$icon.play("destroy")
		remove_from_group("bullet_enemie")
		
	if area.is_in_group("wall"):
		destroy = true
		$icon.play("destroy")
		remove_from_group("bullet_enemie")



func _on_VisibilityNotifier2D_screen_entered():
	queue_free()
