extends Line2D

class_name Edge

var first_node: GNode = null
var second_node: GNode = null
var enabled := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (enabled):
		points = [first_node.position, second_node.position]
		
	if (first_node != null and second_node == null):
		points = [first_node.position, get_global_mouse_position()]

func add_end_node(gnode: GNode) -> void:
	if (first_node == null):
		first_node = gnode
	elif (second_node == null):
		second_node = gnode
		enabled = true
	else:
		print_debug("no space in edge. Overwrite?")

func add_ends(first: GNode, second: GNode) -> void:
	first_node = first
	second_node = second
	enabled = true
