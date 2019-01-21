extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const SPEED = 50
var velocity = Vector2()
const FLOOR = Vector2(0,-1)
var direction = 1
var right
var left

func _ready():
	right = $RayCast2D2
	left = $RayCast2D
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	velocity.x = SPEED * direction
	velocity = move_and_slide(velocity,FLOOR)
	if is_on_wall() || right.is_colliding():
		direction = direction * -1
		right.enabled= false
		left.enabled=true
	elif is_on_wall() || left.is_colliding():
		direction = direction * -1
		left.enabled= false
		right.enabled=true