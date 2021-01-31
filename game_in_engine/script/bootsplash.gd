extends Control



func _on_AnimationPlayer_animation_finished(anim_name):
		if anim_name == "bootsplash":
			get_tree().change_scene("res://scene/main_menu.tscn")
