extends Node2D

var graph_changed_since_last_step := true

var current_algo: Algorithm

#region Resources
@export var graphNode = preload("res://Graph/GNode.tscn")
@export var edge = preload("res://Graph/Edge.tscn")
#endregion

@export var start_node: GNode
var graph_data: GData = preload("res://Graph/GData.tres")

#region Signals
signal graph_changed
#endregion
#region Variables for Options Menu
@export var options_menu: OptionsMenu
var neutral_colour_rect : ColorRect
var current_colour_rect : ColorRect
var boundary_colour_rect: ColorRect
var explored_colour_rect: ColorRect	
#endregion

#region Variables for Edges
var stored_node_for_edge_add: GNode = null
var stored_edge_for_edge_add: Edge = null
var edge_list: Array[Edge] = []
#endregion

#region Godot Methods
func _ready() -> void:
	connect_gnode_to_signals(start_node)
	
	options_menu.colours_changed.connect(on_options_colours_changed)
	on_options_colours_changed()
#endregion

#region UI Buttons & Options Menu
func _on_btn_step_algorithm_pressed() -> void:
	if (graph_changed_since_last_step):	
		load_graph_data()
		setup_algorithm()
	step_algorithm()
	
	graph_changed_since_last_step = false
	
func on_options_colours_changed() -> void:
	neutral_colour_rect  = options_menu.getNeutralColorRect()
	current_colour_rect  = options_menu.getCurrentColorRect()
	boundary_colour_rect = options_menu.getBoundaryColorRect()
	explored_colour_rect = options_menu.getExploredColorRect()
#endregion

#region Algorithm & Graph Management
func setup_algorithm():
	current_algo = options_menu.get_current_algorithm()
	
	current_algo.initialise_algorithm(graph_data)
	reset_node_colours(graph_data.node_array)
func step_algorithm():
	current_algo.step()
	var dsp = current_algo.get_display_data()
	set_graph_display(dsp)

func graph_has_changed() -> void:
	graph_changed_since_last_step = true
	graph_changed.emit()
#endregion


#region Public Methods
func get_graph_data() -> GData:
	return graph_data
	
func set_graph_display(display_data) -> void:
	# display_data is [current, boundary, explored]
	for node in display_data[1]:
		node.change_colour(boundary_colour_rect.color)
	for node in display_data[2]:
		node.change_colour(explored_colour_rect.color)
	display_data[0].change_colour(current_colour_rect.color)
func reset_node_colours(node_array: Array[GNode]) -> void:
	for node in node_array:
		node.change_colour(neutral_colour_rect.color)
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
		graph_has_changed()
#endregion

#region Mouse Interactions
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("left_mouse")):
		graph_has_changed()
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
