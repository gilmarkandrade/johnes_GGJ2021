extends KinematicBody2D
var move = Vector2()
var speed = 100
var gravity = 90
var death = false
var flip = false 
var in_range = false
var can_shoot = true
var in_area_return = false
var life = 10
var bullet = preload("res://enemies/slime/projetil_slime.tscn")
var checkmove = false
var inmove2 = false

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	move.y += gravity
	if death == true:
		move.x = 0
	if death == false:
		
		
		if SingletonGame.player_position.x >= global_position.x :
			flip = false
		else:
			flip = true
		$slimesprite.flip_h = !flip
		if flip == false and in_range == false and can_shoot :
			
			move.x = speed
			if checkmove == false:
				$slimesprite.play("move")
				checkmove = true
			
			
		elif flip == true and in_range == false and can_shoot :
			move.x =- speed
			
			if checkmove == false:
				$slimesprite.play("move")
				checkmove = true
			
		
		elif in_range == true and can_shoot == true :
			
			yield(get_tree().create_timer(1),"timeout")
			if  in_area_return == false and death == false and inmove2 == false:
				can_shoot = false
				$slimesprite.frame = 0
				$slimesprite.play("atk")
				$effect_shoot.play()
				checkmove = true
			if inmove2 == true :
				$slimesprite.play("return")
					
		else:
			
			move.x = 0
			if can_shoot == true:
				if inmove2 == false:
					$slimesprite.play("idle")
					checkmove = true
				else:
					$slimesprite.play("return")
	
	move = move_and_slide(move)


func _on_body_area_entered(area):
	
	if area.is_in_group("bullet") and death == false and inmove2 == false:
		
		if life <= 0 :
			death = true
			$slimesprite.play("death")
			$effectmorte.play()
		else:
			life -= 1
			$effect_dano.play()
			$".".modulate = Color(32,32,32,1)
			yield(get_tree().create_timer(0.2),"timeout")
			$".".modulate = Color(1,1,1,1)
			


func _on_area_range_body_entered(body):
	if body.is_in_group("player"):
		in_range = true


func _on_area_range_body_exited(body):
	if body.is_in_group("player"):
		in_range = false
		can_shoot = true
		checkmove = false


func create_bullet():
	
	var B = bullet.instance()
	get_parent().add_child(B)
	B.position = $Position2D.global_position
	B.flip_h = flip
	

func _on_VisibilityNotifier2D_screen_entered():
	set_physics_process(true)


func _on_VisibilityNotifier2D_screen_exited():

	
	if death == true:
		queue_free()
	else:
		set_physics_process(false)


func _on_slimesprite_animation_finished():
	
	if $slimesprite.animation == "move":
		inmove2 = true
		$slimesprite.play("move2")
	if $slimesprite.animation == "atk":
		can_shoot = true
	if $slimesprite.animation == "return":
		inmove2 = false



func _on_slimesprite_frame_changed():
	if $slimesprite.animation == "atk":
		if $slimesprite.frame == 16:
			create_bullet()
			
