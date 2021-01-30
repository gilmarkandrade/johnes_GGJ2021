extends Node2D
var check = false


func _on_Area2D_body_entered(body):
	
	if body.is_in_group("player") and SingletonGame.get_key == true and check == false:
		check = true
		body.in_cutscene(true)
		$AnimatedSprite.frame = 0
		$AnimatedSprite.play("open")
		yield(get_tree().create_timer(5),"timeout")
		get_tree().change_scene("res://scene/final_game.tscn")
	
	if body.is_in_group("player") and SingletonGame.get_key == false:
		$Label.visible = true



func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		$Label.visible = false











