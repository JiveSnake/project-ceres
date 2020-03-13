extends KinematicBody2D

var input : PlayerInput
var movement : Movement

func _ready():
	setup(PlayerInput.new(), Movement.new())

func _physics_process(delta: float) -> void:
	var action := input.get_action(Input)
	movement.velocity = movement.calculate_velocity(action.moving)
	
	if movement.velocity != Vector2.ZERO:
		move_and_slide(movement.velocity)
		EventsBus.emit_signal("player_moved", self)
		
func setup(input: PlayerInput, movement: Movement) -> void:
	if input:
		self.input = input
	if movement: 
		self.movement = movement
		
	movement.speed_max = 500
	movement.speed_accel  = 100
	movement.boost_max = 1000
	movement.boost_accel = 500
	
	self.add_to_group("players")
	EventsBus.emit_signal("player_created", self)