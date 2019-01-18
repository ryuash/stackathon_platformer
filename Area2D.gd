extends Area2D

signal on_ladder
signal off_ladder

func _ready():
	connect("body_entered",self,"on_player_ladder_enter")
	connect("body_exited",self,"on_player_ladder_leave")
"."
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func on_player_ladder_enter(body):
	if "Player" in body.name:
		emit_signal("on_ladder")
	
func on_player_ladder_leave(body):
	if "Player" in body.name:
		emit_signal("off_ladder")
