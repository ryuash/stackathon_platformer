extends KinematicBody2D

const GRAVITY = 10
var SPEED = 30
const FLOOR = Vector2(0,-1)
export(Vector2)var size=Vector2(1,1);
var velocity = Vector2()
#if direction = 1 the direction is always right in this case. cause we start on the right
var direction = 1
var is_dead = false
export(int)var health = 1
export(int)var attack = 1

func _ready():
	scale=size
	
func dead():
	health-= 1
	if health <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("dead")
		$CollisionShape2D.disabled=true
		yield($AnimatedSprite,"animation_finished")
		queue_free()

func _physics_process(delta):
	if is_dead==false:
		velocity.x = SPEED * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h=false
		else:
			$AnimatedSprite.flip_h=true
		
		$AnimatedSprite.play("walk")
		
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity,FLOOR)
		
	if is_on_wall() || $RayCast2D.is_colliding()==false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
		
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead(attack)
	
