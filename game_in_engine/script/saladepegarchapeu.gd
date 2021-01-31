extends Node2D



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "motion":
		get_tree().change_scene("res://scene/ultimatela.tscn")
