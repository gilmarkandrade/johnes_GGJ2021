extends Node2D

var destroy = false



func _ready():
	SingletonGame.update_key(false)
	
func _on_key_area_body_entered(body):
	if body.is_in_group("player") and destroy == false:
		destroy = true 
		$AnimationPlayer.play("rotate")
		$effect.play()
		SingletonGame.update_key(true)
		yield(get_tree().create_timer(1),"timeout")
		queue_free()
		
