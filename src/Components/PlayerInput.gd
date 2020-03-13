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

func get_action(input: Input) -> Action:
	var action := Action.new()
	var direction := get_direction(input)
	
	action.moving = direction

	if input.is_action_pressed("vent"):
		action.venting = true
		action.moving = Vector2(0, 0)
	elif input.is_action_pressed("attack"):
		action.attacking = true	
	elif input.is_action_pressed("boost"):
		action.boosting = true

	if input.is_action_pressed("scavenge"):
		action.scavenging = true

	return action