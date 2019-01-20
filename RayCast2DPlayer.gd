extends RayCast2D

signal onPlatform
signal offPlatform

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	if is_colliding():
		if("movingPlatform" in get_collider().get_parent().name):
			emit_signal("onPlatform")
		else:
			emit_signal("offPlatform")
