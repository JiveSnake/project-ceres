extends Resource
class_name PlayerInput

func get_direction(input: Input) -> Vector2:
	var direction := Vector2(0, 0)

	if input.is_action_pressed("move_left"):
		direction.x -= 1
	if input.is_action_pressed("move_right"):
		direction.x += 1
	if input.is_action_pressed("move_up"):
		direction.y -= 1
	if input.is_action_pressed("move_down"):
		direction.y += 1
	
	return direction
	
func get_rotation(input: Input) -> int:
	var rotation := 0

	if input.is_action_pressed("rotate_left"):
		rotation = -1
	elif input.is_action_pressed("rotate_right"):
		rotation = 1
	
	return rotation

func get_action(input: Input) -> Action:
	var action := Action.new()

	if input.is_action_pressed("attack"):
		action.attacking = true

	if input.is_action_pressed("boost"):
		action.boosting = true
	else:
		action.boosting = false

	if input.is_action_pressed("scavenge"):
		action.scavenging = true

	return action