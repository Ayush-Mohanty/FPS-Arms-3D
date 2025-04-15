extends Node3D


@onready var hand = $"."

func _process(delta):
	hand.position.x = lerp(hand.position.x,0.0,delta*5)
	hand.position.y = lerp(hand.position.y,-0.119,delta*5)
	
func sway(sway_amout):
		hand.position.x += sway_amout.x*0.00015
		hand.position.y += sway_amout.y*0.00012
		
		hand.position.x += sway_amout.x*0.00001
		hand.position.y += sway_amout.y*0.00001

func _input(event):
	if event is InputEventMouseMotion:
		hand.sway(Vector2(event.relative.x ,event.relative.y ))
