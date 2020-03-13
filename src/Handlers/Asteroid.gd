extends StaticBody2D

func _ready() -> void:
	self.add_to_group("asteroids")
	EventsBus.emit_signal("asteroid_created", self)