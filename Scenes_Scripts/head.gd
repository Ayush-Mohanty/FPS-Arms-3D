extends Node3D

@onready var cam = $"."
@onready var ch3d = $".."
@onready var Anim = $Camera3D/Hand/Sketchfab_Scene2/AnimationPlayer
var v = Vector3()
var sens = 0.12


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Anim.play("Rig|AK_Idle")

func _process(delta):
	cam.rotation_degrees.x = v.x
	ch3d.rotation_degrees.y = v.y
	if Input.is_action_just_pressed("R"):
		Anim.play("Rig|AK_Reload_full")
	if Input.is_action_just_pressed("Shoot"):
		Anim.play("Rig|AK_Shot")

	if Input.is_action_just_pressed("Aim"):
		$Camera3D/Hand/Sketchfab_Scene2/Aim.play("AimAnim")
	if Input.is_action_just_released("Aim"):
		$Camera3D/Hand/Sketchfab_Scene2/Aim.play_backwards("AimAnim")

func _input(event):
	if event is InputEventMouseMotion:
		v.y -= (event.relative.x * sens)
		v.x -= (event.relative.y * sens)
		v.x = clamp(v.x,-80,90)
