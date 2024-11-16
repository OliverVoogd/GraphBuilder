extends Resource

class_name GData
# EdgeArray is a 2D array of bool
@export var edge_array: Array[Array] = []
# list of nodes, idx corresponding to edge connection in EdgeArray
var node_array: Array[GNode] = []
@export var node_to_idx_dict: Dictionary = {}

func initialise_edge_array(n: int) -> void:
	for i in range(n):
		edge_array.push_back([])
		for j in range(n):
			edge_array.back().push_back(false)

func set_node_array(nodes: Array[GNode]) -> void:
	for i in range(nodes.size()):
		node_array.push_back(nodes[i])
		node_to_idx_dict[nodes[i]] = i

func create_edge_array(nodes: Array[GNode], edges: Array[Edge]) -> int:
	set_node_array(nodes)
	
	var n_edges = edges.size()
	var n_nodes = node_array.size()
	
	initialise_edge_array(n_nodes)
	if (node_to_idx_dict.is_empty()):
		print_debug("Empty Node Array")
		return 0
	
	var num_connected_edges = 0
	for i in range(n_edges):
		var first = node_to_idx_dict[edges[i].first_node]
		var second = node_to_idx_dict[edges[i].second_node]
		if (edge_array[first][second] && edge_array[second][first]):
			# already connected
			continue
		edge_array[first][second] = true
		edge_array[second][first] = true
		num_connected_edges += 1
	return num_connected_edges
