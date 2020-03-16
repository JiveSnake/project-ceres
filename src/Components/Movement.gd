extends Resource
class_name Movement

var velocity := Vector2(0, 0)
var speed_decel : = 0
var speed_max := 0
var boost_accel := 0
var boost_max := 0
var rotation_speed := 0
var boost_rotation_speed := 0

func calculate_facing(old_facing: int, is_boosting: bool, rotation_direction: int) -> int:
	if is_boosting:
		return old_facing + (rotation_direction * boost_rotation_speed)
	return old_facing + (rotation_direction * rotation_speed)

func calculate_velocity(facing: int, is_boosting: bool) -> Vector2:
	var new_speed : int
	if is_boosting:
#		new_speed = velocity.length() + boost_accel
		var desired_direction := (boost_max * Vector2(0, -1).rotated(facing)) - velocity
		velocity = velocity + Vector2(desired_direction.x, desired_direction.y) 
#			clamp(desired_direction.x, -boost_accel, boost_accel),
#			clamp(desired_direction.y, -boost_accel, boost_accel)
#		)
#		velocity = Vector2(0, -1).rotated(facing) * min(boost_max, new_speed)
	elif velocity.length() > speed_max:
		new_speed = velocity.length() - speed_decel
		velocity = Vector2(0, -1).rotated(facing) * max(speed_max, new_speed)

	return velocity
