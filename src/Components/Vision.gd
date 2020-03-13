extends Resource
class_name Vision

var vision_range := 0

func calculate_vision(position: Vector2, target: Node) -> void:
#	for group in target.get_groups():
#		if vision.targets.has(group):
#			if position.distance_to(target.position) <= vision.vision_range:
#				vision.targets[group][target] = target
#			else:
#				vision.targets[group].erase(target)
#
	return