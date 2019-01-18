extends Area2D

signal toggleFloorEnter
signal toggleFloorLeave

func _ready():
	connect("body_entered",self,"on_player_toggle_floor_enter")
	connect("body_exited",self,"on_player_toggle_floor_leave")

func on_player_toggle_floor_enter(body):
	if "Player" in body.name:
			emit_signal("toggleFloorEnter")
	
func on_player_toggle_floor_leave(body):
	if "Player" in body.name:
		emit_signal("toggleFloorLeave")
