extends KinematicBody2D
var move = Vector2()
var speed = 50
var gravity = 80
var death = false
var flip = false 
var in_range = false
var can_shoot = true
var in_area_return = false
var life = 3

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	
	if death == false:
		move.y += gravity
		
		if SingletonGame.player_position.x >= global_position.x :
			flip = false
		else:
			flip = true
		
		if flip == false and in_range == false and can_shoot and in_area_return == false:
			move.x = speed
			$AnimationPlayer.play("walking")
			
		elif flip == true and in_range == false and can_shoot and in_area_return == false:
			move.x =- speed
			$AnimationPlayer.play("walking left")
			
		
		elif in_range == true and can_shoot == true and in_area_return == false:
			
			yield(get_tree().create_timer(1),"timeout")
			if  in_area_return == false and death == false:
				can_shoot = false
				if flip == false :
					
					$AnimationPlayer.play("shoot")
				else:
					
					$AnimationPlayer.play("shoot left")
		elif in_area_return == true and in_range == true:
			if flip == false:
				move.x =- speed
				$AnimationPlayer.play_backwards("walking")
			else:
				move.x = speed 
				$AnimationPlayer.play_backwards("walking left")
		else:
			if in_area_return == false:
				move.x = 0
				if can_shoot == true:
					if flip == false:
						$AnimationPlayer.play("idlle")
					else:
						$AnimationPlayer.play("idlle left")
	
	move = move_and_slide(move)


func _on_body_area_entered(area):
	
	if area.is_in_group("bullet") and death == false:
		
		if life <= 0 :
			death = true
			$AnimationPlayer.current_animation = "Death"
		else:
			life -= 1
			$Node2D.modulate = Color(1,0,0,1)
			yield(get_tree().create_timer(0.2),"timeout")
			$Node2D.modulate = Color(1,1,1,1)
			


func _on_area_range_body_entered(body):
	if body.is_in_group("player"):
		in_range = true


func _on_area_range_body_exited(body):
	if body.is_in_group("player"):
		in_range = false
		can_shoot = true


func _on_area_back_body_entered(body):
	if body.is_in_group("player"):
		in_area_return = true
		
func _on_area_back_body_exited(body):
	if body.is_in_group("player"):
		in_area_return = false
		can_shoot = true
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "shoot left" :
		can_shoot = true
	if anim_name == "shoot":
		can_shoot = true
	if anim_name == "death":
		set_physics_process(false)

func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)


func _on_VisibilityNotifier2D_screen_exited():

	
	if death == true:
		queue_free()
	else:
		set_physics_process(false)



