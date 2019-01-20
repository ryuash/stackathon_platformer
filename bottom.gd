extends Area2D

signal bottom

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	pass

func _on_bottom_body_entered(body):
	if "verticalMovingPlatform" in body.name:
		emit_signal("bottom")
