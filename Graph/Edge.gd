extends Line2D

class_name Edge

var first_node: GNode = null
var second_node: GNode = null
var enabled := false

var first_position: Vector2 = Vector2.ZERO
var mouse_tracking := false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (enabled):
		points = [first_node.position, second_node.position]
	elif mouse_tracking:
		points = [first_position, get_global_mouse_position()]

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
	
func add_mouse_tracking(start: Vector2):
	first_position = start
	mouse_tracking = true
