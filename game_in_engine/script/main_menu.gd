extends Control

var pressed = false
func _ready():
	$CanvasLayer/play.grab_focus()

func _on_play_pressed():
	if pressed == false :
		pressed = true
		$CanvasLayer/effect_clicked.play()
		$AnimationPlayer.play_backwards("openmenu")
		yield(get_tree().create_timer(1),"timeout")
		get_tree().change_scene("res://scene/main.tscn")
		
		
func _on_play_focus_entered():
	if pressed == false :
		$CanvasLayer/effect_hoverfocus.play()
		


func _on_creditos_pressed():
	if pressed == false :
		pressed = true
		$CanvasLayer/effect_clicked.play()
		$AnimationPlayer.play("creditos")

func _on_creditos_focus_entered():
	if pressed == false :
		$CanvasLayer/effect_hoverfocus.play()


func _on_back_pressed():
	$AnimationPlayer.play_backwards("creditos")
	pressed = false

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
