extends ColorRect

signal fade_finished

func fadeIn():
	print("i am playing")
	$AnimationPlayer.play("fadeIn")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finished")
