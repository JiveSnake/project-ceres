extends Node2D

var astar = AStar.new()

var nodes := {
	allies = Dictionary(),
	enemies = Dictionary(),
	junkpiles = Dictionary(),
	players = Dictionary(),
	projectiles = Dictionary()
}

func _ready():
	EventsBus.connect("ally_created", self, "_add_to_nodes")
	EventsBus.connect("enemy_created", self, "_add_to_nodes")
	EventsBus.connect("player_created", self, "_add_to_nodes")
	EventsBus.connect("projectile_created", self, "_add_to_nodes")
	EventsBus.connect("junkpile_created", self, "_add_to_nodes")
	
	EventsBus.connect("ally_destroyed", self, "_remove_from_nodes")
	EventsBus.connect("enemy_destroyed", self, "_remove_from_nodes")
	EventsBus.connect("player_destroyed", self, "_remove_from_nodes")
	EventsBus.connect("projectile_destroyed", self, "_remove_from_nodes")
	EventsBus.connect("junkpile_destroyed", self, "_remove_from_nodes")

#func _add_to_nodes(node: Node) -> void:
#	for group in node.get_groups():
#		if GameState.nodes.has(group):
#			GameState.nodes[group][node] = node
#
#func _remove_from_nodes(node: Node) -> void:
#	for group in node.get_groups():
#		if GameState.nodes.has(group):
#			GameState.nodes[group].erase(node)
#
#func _build_astar_graph() -> void:
#	var projectResolution := Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/width"))
