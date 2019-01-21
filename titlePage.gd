extends Control

func _ready():
	$AudioStreamPlayer.play()
	$MarginContainer/VBoxContainer/HBoxContainer/start.grab_focus()

func _physics_process(delta):
	if($MarginContainer/VBoxContainer/HBoxContainer/start.is_hovered() == true):
		$MarginContainer/VBoxContainer/HBoxContainer/start.grab_focus()
	if($MarginContainer/VBoxContainer/HBoxContainer/exit.is_hovered() == true):
		$MarginContainer/VBoxContainer/HBoxContainer/exit.grab_focus()


func _on_start_pressed():
	$select.play()
	$sceneTransition.show()
	$sceneTransition.fadeIn()

func _on_exit_pressed():
	get_tree().quit()

func _on_sceneTransition_fade_finished():
	$sceneTransition.hide()
	get_tree().change_scene("stageOne.tscn")
