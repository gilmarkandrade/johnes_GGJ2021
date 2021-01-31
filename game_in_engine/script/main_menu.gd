extends Control

var pressed = false
func _ready():
	$CanvasLayer/play.grab_focus()

func _on_play_pressed():
	if pressed == false :
		pressed = true
		$CanvasLayer/effect_clicked.play()
		$AnimationPlayer.play_backwards("openmenu")
		yield(get_tree().create_timer(2),"timeout")
		get_tree().change_scene("res://scene/tela de entrada.tscn")
		
		
func _on_play_focus_entered():
	if pressed == false :
		$CanvasLayer/effect_hoverfocus.play()
		


func _on_creditos_pressed():
	if pressed == false :
		pressed = true
		$CanvasLayer/effect_clicked.play()
		$animation_credits.play("motion")
		$CanvasLayer/back.grab_focus()
		$CanvasLayer/back.visible = true
		
func _on_creditos_focus_entered():
	if pressed == false :
		$CanvasLayer/effect_hoverfocus.play()
	

func _on_back_pressed():
	$animation_credits.play_backwards("motion")
	pressed = false
	$CanvasLayer/back.visible = false
	$CanvasLayer/creditos.grab_focus()
	$CanvasLayer/effect_clicked.play()
	
func _on_back_focus_entered():
	if pressed == false :
		$CanvasLayer/effect_hoverfocus.play()
		


func _on_quit_pressed():
	if pressed == false :
		pressed = true
		$CanvasLayer/effect_clicked.play()
		get_tree().quit()


func _on_quit_focus_entered():
		if pressed == false :
			$CanvasLayer/effect_hoverfocus.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "openmenu":
		$AnimationPlayer.play("motion")
	



func _on_pt_focus_entered():
	TranslationServer.set_locale("pt")


func _on_en_focus_entered():
	TranslationServer.set_locale("en")
