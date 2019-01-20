extends Area2D

const SPEED = 100
var velocity = Vector2()
# 1 is right and -1 is left
var direction = 1
func _ready():

	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1 :
		$AnimatedSprite.flip_h=false
	else:
		$AnimatedSprite.flip_h=true
		$CollisionShape2D.position.x *= -1

func _physics_process(delta):
	velocity.x=SPEED*delta*direction
	translate(velocity)
	$AnimatedSprite.play("attack")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_fireBall_body_entered(body):
	if "Enemy" in body.name:
		#print(body.name,'body name')
		body.dead()
	queue_free()
