extends Node2D

#region Resources
@export var graphNode = preload("res://Graph/GNode.tscn")
@export var edge = preload("res://Graph/Edge.tscn")
#endregion

@export var start_node: GNode
var graph_data: GData = preload("res://Graph/GData.tres")

#region Variables for Edges
var stored_node_for_edge_add: GNode = null
var edge_list: Array[Edge] = []
#endregion

#region Godot Methods
func _ready() -> void:
	connect_nodes_to_signals(start_node)
#endregion

#region Public Methods
func get_graph_data() -> GData:
	return graph_data
#endregion

#region Creating Nodes
func add_new_node(mouse_position: Vector2) -> void:
	var new_node = graphNode.instantiate()
	new_node.position = get_local_mouse_position()
	connect_nodes_to_signals(new_node)
	add_child(new_node)

func connect_nodes_to_signals(node: GNode):
	node.connect("edit_edge_button_clicked", recieve_gnode_edit_edge_button)
#endregion
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

#region GData structure
func collect_nodes() -> Array[GNode]:
	var graphNodes: Array[GNode] = []
	
	for child in get_children():
		if (child is GNode):
			graphNodes.push_back(child)
	return graphNodes

func collect_edges() -> Array[Edge]:
	return edge_list # for now, assume no duplicates in edge_list
	
func load_graph_data():
	print_debug("load data")
	var number_edges = graph_data.create_edge_array(collect_nodes(), collect_edges())
	graph_data.set_start_gnode(start_node)
	print_debug("edge count: ", number_edges)
#endregion
