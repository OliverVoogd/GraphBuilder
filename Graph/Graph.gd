extends Node2D

#region Resources
@export var graphNode = preload("res://Graph/GNode.tscn")
@export var edge = preload("res://Graph/Edge.tscn")
#endregion

@export var start_node: GNode
var graph_data: GData = preload("res://Graph/GData.tres")

@export var neutral_colour := Color.ANTIQUE_WHITE
@export var current_colour := Color.DIM_GRAY
@export var explored_colour := Color.DARK_RED
@export var boundary_colour := Color.YELLOW_GREEN

#region Variables for Edges
var stored_node_for_edge_add: GNode = null
var stored_edge_for_edge_add: Edge = null
var edge_list: Array[Edge] = []
#endregion

#region Godot Methods
func _ready() -> void:
	connect_gnode_to_signals(start_node)
#endregion

#region Public Methods
func get_graph_data() -> GData:
	return graph_data
	
func set_graph_display(display_data) -> void:
	# display_data is [current, boundary, explored]
	for node in display_data[1]:
		node.change_colour(boundary_colour)
	for node in display_data[2]:
		node.change_colour(explored_colour)
	display_data[0].change_colour(current_colour)
func reset_node_colours(node_array: Array[GNode]) -> void:
	for node in node_array:
		node.change_colour(neutral_colour)
#endregion

#region Creating Nodes & Edges
func add_new_node(mouse_position: Vector2) -> void:
	var new_node = graphNode.instantiate()
	new_node.position = get_local_mouse_position()
	connect_gnode_to_signals(new_node)
	add_child(new_node)

func connect_gnode_to_signals(node: GNode):
	node.connect("edit_edge_button_clicked", recieve_gnode_edit_edge_button)

func create_edge_between_gnodes(node1: GNode, node2: GNode):
	var new_edge = edge.instantiate()
	new_edge.add_ends(node1, node2)
	edge_list.push_back(new_edge)
	add_child(new_edge)
func cancel_create_edge():
	remove_child(stored_edge_for_edge_add)
	stored_edge_for_edge_add = null
	stored_node_for_edge_add = null
#endregion

#region Signals from GNodes
func remove_GNode(node: GNode):
	pass
	
func recieve_gnode_edit_edge_button(clicked_node: GNode):
	if (stored_node_for_edge_add == null):
		stored_node_for_edge_add = clicked_node
		# create a temporary edge for visual clue
		stored_edge_for_edge_add = edge.instantiate()
		stored_edge_for_edge_add.add_mouse_tracking(stored_node_for_edge_add.position)
		add_child(stored_edge_for_edge_add)
	elif (stored_node_for_edge_add != null):
		if (stored_node_for_edge_add == clicked_node):
			print_debug("same node clicked")
			return
		create_edge_between_gnodes(stored_node_for_edge_add, clicked_node)
		cancel_create_edge()
#endregion

#region Mouse Interactions
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("left_mouse")):
		if (stored_node_for_edge_add != null):
			stored_node_for_edge_add = null
			remove_child(stored_edge_for_edge_add)
			return
		add_new_node(get_global_mouse_position())


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
