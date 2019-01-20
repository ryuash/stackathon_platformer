extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal health(health)

func _ready():
	get_node("HBoxContainer/TextureProgress").set_value(10)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_healthChange(health):
	get_node("HBoxContainer/TextureProgress").set_value(health)
