extends CharacterBody3D

const SPEED = 3
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var PLAYER = null
@onready var AGENT = $NavigationAgent3D


var NEXT_LOCATION
var CURRENT_POSITION
var FIRST_CHECK = false

func _ready():
	PLAYER = find_node_recursive(get_tree().current_scene, "player")

func _physics_process(delta):
	if PLAYER == null:
		return

	if not is_on_floor():
		velocity.y -= gravity * delta

	NEXT_LOCATION = AGENT.get_next_path_position()
	CURRENT_POSITION = global_transform.origin

	var result = player_view_ray()
	if result and result.collider == PLAYER and FIRST_CHECK:
		AGENT.target_position = PLAYER.global_transform.origin
		look_at(Vector3(AGENT.target_position.x, position.y, AGENT.target_position.z))

	velocity = velocity.move_toward((NEXT_LOCATION - CURRENT_POSITION).normalized() * SPEED, 0.25)
	move_and_slide()

	FIRST_CHECK = true

func player_view_ray():
	var space_state = get_world_3d().direct_space_state
	var ray_start = global_transform.origin
	var ray_end = PLAYER.global_transform.origin

	var ray_query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	ray_query.exclude = [self]

	return space_state.intersect_ray(ray_query)

func find_node_recursive(root: Node, name: String) -> Node:
	if root.name == name:
		return root
	for child in root.get_children():
		var result = find_node_recursive(child, name)
		if result != null:
			return result
	return null
