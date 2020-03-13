extends Resource
class_name Targeting

var priority_list := Array()

func determine_target(nodes: Dictionary, current_position: Vector2, vision: Vision) -> Node2D:
	var target : Node2D
	for priority in priority_list:
		if nodes.has(priority):
			for node in nodes[priority].values():
				if current_position.distance_to(node.position) <= vision.vision_range:
					return node
	return target
