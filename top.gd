extends Area2D

signal top

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_top_body_entered(body):
	if "verticalMovingPlatform" in body.name:
		emit_signal("top")
