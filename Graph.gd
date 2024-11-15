extends Node2D

@export var graphNode = preload("res://GNode.tscn")
@export var edge = preload("res://edge.tscn")
#region Variables for Edges
var stored_node_for_edge_add: GNode = null
var edge_list: Array[Edge] = []
#endregion
func add_new_node(mouse_position: Vector2) -> void:
	var newNode = graphNode.instantiate()
	newNode.position = get_local_mouse_position()
	newNode.connect("edit_edge_button_clicked", recieve_gnode_edit_edge_button)
	add_child(newNode)

func collect_nodes() -> Array[GNode]:
	var graphNodes: Array[GNode] = []
	
	for child in get_children():
		if (child is GNode):
			graphNodes.push_back(child)
		
	print_debug(graphNodes.size())
	return graphNodes
	
#region Signals from GNodes
func remove_GNode(node: GNode):
	pass
	
func recieve_gnode_edit_edge_button(clicked_node: GNode):
	if (stored_node_for_edge_add == null):
		stored_node_for_edge_add = clicked_node
		var new_edge = edge.instantiate()
		new_edge.add_end_node(stored_node_for_edge_add)
		edge_list.push_back(new_edge)
		add_child(new_edge)
	elif (stored_node_for_edge_add != null):
		if (stored_node_for_edge_add == clicked_node):
			print_debug("same node clicked")
			return
		var current_edge = edge_list.back()
		current_edge.add_end_node(clicked_node)
		stored_node_for_edge_add = null
#endregion

#region Mouse Interactions
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("left_mouse")):
		place_node(get_global_mouse_position())


func place_node(mousePosition: Vector2) -> void:
	add_new_node(mousePosition)

#endregion
