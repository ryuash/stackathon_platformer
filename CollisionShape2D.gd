extends CollisionShape2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass



func _on_Area2D_toggleFloorEnter():
	set_collision_mask(2)
