extends KinematicBody2D


const FLOOR = Vector2(0,-1)
const GRAVITY = 12
export(Vector2)var size=Vector2(1,1);

var velocity = Vector2(0,0)

var Player

func _ready():
	velocity.y = -150
	Player = get_tree().get_root().get_node("stageOne").get_node("Player")
	add_collision_exception_with(Player)
	scale=size
	$AnimatedSprite.play("spin")
	pass

func _physics_process(delta):
	velocity.y+=GRAVITY
	velocity=move_and_slide(velocity,FLOOR)

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		velocity.y=-200
		$AudioStreamPlayer.play()
		get_node("Area2D/CollisionShape2D").disabled=true

func _on_AudioStreamPlayer_finished():
	queue_free()
