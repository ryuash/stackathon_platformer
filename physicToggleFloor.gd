extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Player;
#.get_node("stageOne/Player")
var toggle = false
var inArea;

func _ready():
	Player = get_tree().get_root().get_node("stageOne").get_node("Player")

func _physics_process(delta):
	if Input.is_action_pressed("ui_down") && inArea:
		add_collision_exception_with(Player)
	else:
		remove_collision_exception_with(Player)
	


func _on_Area2D_toggleFloorEnter():
	inArea = true


func _on_Area2D_toggleFloorLeave():
	inArea=false


func _on_StaticBody2D_input_event(viewport, event, shape_idx):
	pass # replace with function body
