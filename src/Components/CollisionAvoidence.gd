extends Resource
class_name CollisionAvoidence

var avoidance_distance := 0
var previous_vector := Vector2()
var smoothing := 20
var frame_count := smoothing

func determine_direction(moving_body: KinematicBody2D, target: Node2D) -> Vector2:
	if frame_count < smoothing:
		frame_count += 1
		return previous_vector.normalized()
		
	var direction_to_target := moving_body.position.direction_to(target.position)
	var new_vector := avoidance_distance * moving_body.position.direction_to(target.position)
	
	var collision := _check_for_collision(moving_body, new_vector)
	if collision and collision.get_collider() != target:
		
		new_vector = _calculate_deflected_vector(moving_body, collision)

		var vector_to_collision := moving_body.position.direction_to(collision.get_position())
		var vector_to_collider := moving_body.position.direction_to(collision.get_collider().get_position())
		var direction := 1 if rad2deg(vector_to_collision.angle_to(vector_to_collider)) > 0 else -1

		new_vector *= direction
			
	previous_vector = new_vector
	frame_count = 0
	return new_vector.normalized()

func _check_for_collision(moving_body: KinematicBody2D, velocity: Vector2) -> KinematicCollision2D:
	return moving_body.move_and_collide(velocity, false, true, true)

func _calculate_deflected_vector(moving_body: KinematicBody2D, collision: KinematicCollision2D) -> Vector2:
	var vector_to_collision := moving_body.position.direction_to(collision.get_position())
	var tangent_vector := vector_to_collision.tangent().normalized()
	
	var moving_shape : CircleShape2D = moving_body.get_node("CollisionShape2D").shape
	var collider_shape : CircleShape2D = collision.get_collider().get_node("CollisionShape2D").shape

	return tangent_vector * moving_shape.get_radius() * collider_shape.get_radius()
