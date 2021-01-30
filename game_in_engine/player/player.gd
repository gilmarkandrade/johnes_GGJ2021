extends KinematicBody2D
var can_jump = false
var move = Vector2(0,0)
var up = Vector2(0,-1)
var flip_h = false
var jump_force = -1100

const max_speed = 500
const gravity = 60


func _physics_process(delta):
	move.y += gravity
	
	if Input.is_action_pressed("ui_left"):
		if -max_speed <= move.x:
			move.x -= 5 *2.5
			
		else: 
			move.x = -max_speed - 50
			
			
	elif Input.is_action_pressed("ui_right"):
		if max_speed >= move.x: 
			move.x += 5*2.5
			
		else:
			move.x = max_speed + 50
			
	else:
		move.x = 0
	
	if is_on_floor():
			can_jump = true
			
				
	if Input.is_action_just_released("ui_jump"):
			can_jump = false
			
	if can_jump == true :
		if Input.is_action_pressed("ui_jump") :
				
			if jump_force <= move.y  :
					move.y -= (150)
			else:
				can_jump = false
					
			print(move.y)
					
		else:
			if !is_on_floor() :
					
				can_jump = false
					
					
			
		if move.y <- 0.1 :
				if flip_h == false:
					pass
						
				elif flip_h == true:
					pass
					
		if move.y > 0.1 and is_on_floor() == false:
				if flip_h == false :
					pass
				elif flip_h == true :
					pass
	

	move = move_and_slide_with_snap( move, Vector2(0, 1), Vector2(up))
