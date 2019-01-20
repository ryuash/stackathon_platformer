extends KinematicBody2D


const SPEED = 80
const GRAVITY = 12
const JUMP_POWER = -250
const FLOOR = Vector2(0,-1)
const CLIMB_SPEED = 70
const FIREBALL = preload("res://fireBall.tscn")

var velocity = Vector2()
var is_dead = false
var on_ladder = false
var on_platform = false
var is_attacking = false
var delay = 0.3
var timer = null
var winOrDieTimer = null
var winOrDieDelay = 2
var health = 10
var cont = 0
var text_actual = null
var win = false

signal hit(pos)
signal healthChange(health)

func _ready():
	timer = Timer.new()
	timer.set_wait_time(delay)
	timer.set_one_shot(true)
	timer.connect("timeout",self,"on_time_complete")
	add_child(timer)
	winOrDieTimer=Timer.new()
	winOrDieTimer.set_wait_time(winOrDieDelay)
	winOrDieTimer.set_one_shot(true)
	winOrDieTimer.connect("timeout",self,"win_or_dead_time_complete")
	add_child(winOrDieTimer)
	pass
	
func on_time_complete():
	is_attacking=false
	
func win_or_dead_time_complete():
	#change back to title here
	if(health>0):
		win = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("idle")
		print("you won!")
#	change to title here
	else:
		print("you died")
	text_actual.queue_free()

func _physics_process(delta):
	velocity.y+=GRAVITY
#	on_ladder = "ladder" in get_tile_on_position(position.x,position.y)

	if is_dead == false && !win:
#		talking
#		if Input.is_action_just_pressed("ui_down"):
#			print("i hit down input")
#			if cont == 0:
#				_speak("Congrats, you won")
#			elif cont == 1:
#				text_actual.queue_free()
#				cont = 0
#				return
#			cont += 1
			
	#	walking
		if(Input.is_action_pressed("ui_right")):
			if sign($Position2D.position.x)== -1:
					$Position2D.position.x *= -1
			velocity.x=SPEED
			$AnimatedSprite.flip_h=false
			$AnimatedSprite.play("walk")
		elif(Input.is_action_pressed("ui_left")):
			if sign($Position2D.position.x)== 1:
					$Position2D.position.x *= -1
			velocity.x=-SPEED
			$AnimatedSprite.flip_h=true
			$AnimatedSprite.play("walk")
		else:
			velocity.x=0
			$AnimatedSprite.play("idle")
			
		if Input.is_action_just_pressed("ui_select") && is_attacking==false:
				is_attacking=true
				$AnimatedSprite.play("punch")
				#start timer for shooting delay
				timer.start()
				var shootInstance = FIREBALL.instance()
				if sign($Position2D.position.x) == 1 :
					shootInstance.set_fireball_direction(1)
				else:
					shootInstance.set_fireball_direction(-1)
				get_parent().add_child(shootInstance)
				shootInstance.position = $Position2D.global_position
			
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


func _on_RayCast2D_onPlatform():
	on_platform=true
#	GRAVITY=0


func _on_RayCast2D_offPlatform():
	on_platform=false
#	GRAVITY=12

func dead(attack):
	print(attack,"attack from enemy")
	health-=attack
	emit_signal("healthChange",health)
	if health <= 0 :
		winOrDieTimer.start()
		is_dead=true
		_speak("oh nos, you died")
		velocity = Vector2(0,0)
		$CollisionShape2D.disabled=true
		$AnimatedSprite.play("idle")
	print(health,"health")
	
func _speak(text):
	print("i hit speak")
	var container_text = load("res://stackathon-assets/Text/Label.tscn").instance()
	container_text._text(text)
	add_child(container_text)
	text_actual = container_text
	
func win():
	if !win:
		_speak("Congrats, you won")
		winOrDieTimer.start()
	
