extends Resource
class_name Movement

var velocity := Vector2(0, 0)
var speed_accel := 0
var speed_max := 0
var boost_max := 0
var boost_accel := 0

func calculate_velocity(new_direction: Vector2) -> Vector2:
	var new_speed := velocity.length() + speed_accel
	
	return new_direction * min(speed_max, new_speed)