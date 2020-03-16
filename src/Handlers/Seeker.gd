extends KinematicBody2D

var movement : Movement
var target_position : Vector2
var vision : Vision
var collision_avoidence : CollisionAvoidence

func _ready() -> void:
	setup(EventsBus, Movement.new(), Targeting.new(), Vision.new(), CollisionAvoidence.new())
	
func _physics_process(delta: float) -> void:
	var target := targeting.determine_target(GameState.nodes, self.position, vision) as Node2D

	if target:
		var new_direction : Vector2 = collision_avoidence.determine_direction(self, target)
		movement.velocity = movement.calculate_velocity(new_direction)
		
		if movement.velocity != Vector2.ZERO:
			move_and_slide(movement.velocity)
			EventsBus.emit_signal("seeker_moved", self)

func _update_target(player: KinematicBody2D) -> void:
	target_position = player.position

func setup(bus, movement: Movement, targeting: Targeting, vision: Vision, collision_avoidence: CollisionAvoidence) -> void:
	bus.connect("player_moved", self, "_update_target")
	
	if movement:
		self.movement = movement
	if targeting:
		self.targeting = targeting
	if vision:
		self.vision = vision
	if collision_avoidence:
		self.collision_avoidence = collision_avoidence
	
	movement.speed_max = 200
	movement.speed_accel  = 80
	
	targeting.priority_list.append("players")
	
	vision.vision_range = 900
	
	var shape := (get_node("CollisionShape2D") as CollisionShape2D).shape
	collision_avoidence.avoidance_distance = shape.get_radius() as int
	
	self.add_to_group("seekers")
	bus.emit_signal("seeker_created", self)