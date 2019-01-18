extends KinematicBody2D


const SPEED = 80
const GRAVITY = 12
const JUMP_POWER = -250
const FLOOR = Vector2(0,-1)
const CLIMB_SPEED = 70

var velocity = Vector2()
var is_dead = false
var on_ladder = false

signal hit(pos)

func _ready():
	pass

func _physics_process(delta):
	velocity.y+=GRAVITY
#	on_ladder = "ladder" in get_tile_on_position(position.x,position.y)


#	walking
	if(Input.is_action_pressed("ui_right")):
		velocity.x=SPEED
		$AnimatedSprite.flip_h=false
		$AnimatedSprite.play("walk")
	elif(Input.is_action_pressed("ui_left")):
		velocity.x=-SPEED
		$AnimatedSprite.flip_h=true
		$AnimatedSprite.play("walk")
	else:
		velocity.x=0
		$AnimatedSprite.play("idle")
		
#		jumping
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
				
				velocity = Vector2(0, -1)
				velocity.y=JUMP_POWER
	else:
		$AnimatedSprite.play("jump")
		
#	checking ladder
	if on_ladder:
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite.play("climb")
			velocity = Vector2(0, -1)
			velocity.y -= CLIMB_SPEED
		elif Input.is_action_pressed("ui_down"):
			$AnimatedSprite.play("climb")
#			doesnt work because of collission issue
			velocity = Vector2(0, 1)
			velocity.y += CLIMB_SPEED
		else:
			$AnimatedSprite.play("climb-still")
			velocity.y=0
	
	velocity=move_and_slide(velocity,FLOOR)
	
#func get_tile_on_position(x,y):
#	var tilemap = get_parent().get_node("ladder")
#	if not tilemap == null:
#		var map_pos = tilemap.world_to_map(Vector2(x,y))
#		var id = tilemap.get_cellv(map_pos)
#		if id > -1:
#			var tilename = tilemap.get_tileset().tile_get_name(id)
#			return tilename
#		else:
#			return ""
#

func _on_Area2D_on_ladder():
	on_ladder=true
	print("on ladder from player signal")


func _on_Area2D_off_ladder():
	on_ladder=false
	print("off ladder")
