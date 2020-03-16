extends KinematicBody2D

var input : PlayerInput
var movement : Movement

func _ready():
	setup(PlayerInput.new(), Movement.new())

func _physics_process(delta: float) -> void:
	var action := input.get_action(Input)
	var rotation_direction := input.get_rotation(Input)

	if rotation_direction != 0:
		self.rotation_degrees = movement.calculate_facing(self.rotation_degrees, action.boosting, rotation_direction)

#	movement.velocity = movement.calculate_velocity(self.rotation, action.boosting)

	move_and_slide(movement.calculate_velocity(self.rotation, action.boosting))
	EventsBus.emit_signal("player_moved", self)
		
func setup(input: PlayerInput, movement: Movement) -> void:
	if input:
		self.input = input
	if movement: 
		self.movement = movement
	
	movement.speed_max = 500
	movement.speed_decel  = 100
	movement.boost_max = 1000
	movement.boost_accel = 500
	movement.rotation_speed = 5
	movement.boost_rotation_speed = 2
	
	self.add_to_group("players")
	EventsBus.emit_signal("player_created", self)