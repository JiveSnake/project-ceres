extends Node2D

var resolution : Vector2
var tiles : Array

func _ready() -> void:
	setup(
	EventsBus,
		Vector2(
			ProjectSettings.get_setting("display/window/size/width"),
			ProjectSettings.get_setting("display/window/size/height")
		)
	)

func _update_tiles(player: KinematicBody2D) -> void:
	pass

func setup(bus, displayResolution: Vector2) -> void:
	bus.connect("player_moved", self, "_update_tiles")
	resolution = displayResolution
	
#	for i in range(9):
#		var sprite = Sprite.new()
#		sprite.region_enabled(true)
#		var position = Vector2(0, 0)
#		var region_rect = Rect2(position, resolution)
#		sprite.region_rect(
#		add_child(sprite)
#		sprite.name = "Tile_" + str(i)