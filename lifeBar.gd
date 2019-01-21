extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal health(health)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func startHealth(health):
	get_node("HBoxContainer/TextureProgress").set_value(health)
	get_node("HBoxContainer/TextureProgress").set_max(health)


func _on_Player_healthChange(health):
	get_node("HBoxContainer/TextureProgress").set_value(health)

func enemyHealthChange(health):
	get_node("HBoxContainer/TextureProgress").set_value(health)