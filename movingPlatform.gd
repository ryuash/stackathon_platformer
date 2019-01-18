extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#var speed = Vector2()
#var acc = Vector2()
#var direction = 1

func _ready():
	$AnimationPlayer.play("lift")
	set_physics_process(true)
	
#func _physics_process(delta):
#	acc.y = 50
#	acc.x = 0
#	speed.x = (acc.x*delta)
#	speed.y = (acc.y*direction)
#	if(get_position()==Vector2(256,-16)):
#		direction=1
#	elif(get_position()==Vector2(256,96)):
#		print("hit")
#		direction=-1


#var time = 0
#
#var speed = Vector2()

func _physics_process(delta):
#	time += delta
#	speed.y = 128*cos(2*PI*time/float(2)*2)
	
#	position += speed*delta
	#move_and_slide(speed)
	#position.y += speed.y*delta
	pass


#	move_and_slide(speed)