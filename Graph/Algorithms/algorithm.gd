extends Resource

class_name Algorithm

@export var algorithm_name = "Abstract"


var graph_data: GData = null
# reimpliment as queues
var explored: Array[int] = []
var boundary: Array[int] = []
var algorithm_finished: bool = false


func reset() -> void:
	print_debug("Abstract class")
	pass
func initialise_algorithm(data: GData) -> void:
	print_debug("Abstract class")
	pass
func get_display_data() -> Array:
	print_debug("Abstract class")
	return []
func step() -> Array[int]:
	print_debug("Abstract class")
	return []
