extends Control

func _ready():
	$BG.play()
	yield(get_tree().create_timer(5.0), "timeout")
	$AnimationPlayer.play("Start")



func _on_Start_pressed():
	$ButtontPressed.play()
	TransitionScreen.fade_in("res://Scenes/Stages/Fase0.tscn")
	


func _on_Fullscreen_pressed():
	$ButtontPressed.play()
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Exit_pressed():
	$ButtontPressed.play()
	get_tree().quit()

func _on_Start_focus_exited():
	$FocusEntered.play()

func _on_Fullscreen_focus_exited():
	$FocusEntered.play()

func _on_Exit_focus_exited():
	$FocusEntered.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	$Start.grab_focus()
