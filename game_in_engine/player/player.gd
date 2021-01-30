extends KinematicBody2D
var can_jump = false
var move = Vector2(0,0)
var up = Vector2(0,-1)
var flip_h = false
var jump_force = -1200
var check_idle = false
var check_return_moviment = false
const max_speed = 500
const gravity = 60
var idlle_smooking = false
var bullet = preload("res://player/bullet/bullet.tscn")
var can_shot = true
var on_floor = false
var death = false

func _physics_process(delta):
	SingletonGame.update_pos_player(global_position)
	if death == true:
		
		$AnimationPlayer.current_animation = "death"
		move.x = 0
		if Engine.time_scale >= 0.2:
			Engine.time_scale -= 0.02
			print(Engine.time_scale)
			
	if death == false:
		move.y += gravity
		flip_h = $Sprite.flip_h
		
		if !$RayCast2D.is_in_group("player"):
			on_floor = $RayCast2D.is_colliding()
			
		if Input.is_action_just_pressed("ui_shoot") and check_idle == false and can_shot:
			if idlle_smooking == false:
				bullet()
				can_shot = false
				yield(get_tree().create_timer(0.2),"timeout")
				can_shot = true
			else:
				if check_return_moviment == false:
					$AnimationPlayer.play("return_idlle")
					check_return_moviment = true
					
		
		if Input.is_action_just_released("ui_left") :
			move.x = 0
			
		elif Input.is_action_just_released("ui_right"):
			move.x = 0
			
		elif Input.is_action_pressed("ui_left"):
			$Sprite.flip_h = true
			flip_h = $Sprite.flip_h
			if idlle_smooking == false:
				if -max_speed <= move.x:
					move.x -= 5 *2.5
					
				else: 
					move.x = -max_speed - 50
				if is_on_floor():
					$AnimationPlayer.current_animation = "run"
					check_idle = false
			else:
				if check_return_moviment == false:
					$AnimationPlayer.play("return_idlle")
					check_return_moviment = true
					
		
		elif Input.is_action_pressed("ui_right"):
			$Sprite.flip_h = false
			
			if idlle_smooking == false:
				if max_speed >= move.x: 
					move.x += 5*2.5
					
				else:
					move.x = max_speed + 50
				if is_on_floor():
					$AnimationPlayer.current_animation = "run"
					check_idle = false
			else:
				if check_return_moviment == false:
					$AnimationPlayer.play("return_idlle")
					check_return_moviment = false
					
		
					
		else:
			move.x = 0
			if on_floor:
				if check_idle == false:
					
					check_idle = true
					$AnimationPlayer.play("idlle")
					$delay_fumando.start()
					
				
				if Input.is_action_just_pressed("ui_shoot") and move.x == 0 and on_floor:
					if idlle_smooking == false  :
						$AnimationPlayer.play("shoot")
						$delay_fumando.stop()
						
					else:
						if check_return_moviment == false :
							$AnimationPlayer.play("return_idlle")
							check_return_moviment = true
							
		
		#===================================================================
		#              JUMP
		#===================================================================
		if on_floor:
			can_jump = true
				
		
		if Input.is_action_just_released("ui_jump"):
				can_jump = false
		if !on_floor and !Input.is_action_pressed("ui_jump"):
				can_jump = false
		
		if can_jump == true :
			if Input.is_action_pressed("ui_jump") :
				
				if idlle_smooking == true:
					
					if check_return_moviment == false:
						check_return_moviment = true
						$AnimationPlayer.play("return_idlle")
				else:
					if jump_force <= move.y :
							move.y -= (150)
						
					else:
						can_jump = false
								
		if on_floor == false:
			if move.y >- 0.001  :
				$AnimationPlayer.current_animation = "jump_dow"
				check_idle = false
				$delay_fumando.stop()
				
			if move.y <- 0.001  :
				$AnimationPlayer.current_animation ="jump_up"
				check_idle = false
				$delay_fumando.stop()
										
			
					
	move = move_and_slide_with_snap( move, Vector2(0, 1), Vector2(up))


func bullet():
	var B = bullet.instance()
	get_parent().add_child(B)
	B.flip_h = flip_h
	
	if flip_h == true:
		B.global_position = $p_l.global_position
	else:
		B.global_position = $p_r.global_position
		
func _on_delay_fumando_timeout():
	
	idlle_smooking = true
	$AnimationPlayer.play("idlle_2")


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if anim_name == "idlle_2":
		$AnimationPlayer.play("idlle_3")
		
	if anim_name == "return_idlle":
		idlle_smooking = false
		check_idle = false
		check_return_moviment = false
		
	if anim_name == "shoot":
		check_idle = false
	if anim_name == "death":
		Engine.time_scale = 1
		set_physics_process(false)

func _on_area_body_area_entered(area):
	if area.is_in_group("weapom_enemie"):
		death = true
