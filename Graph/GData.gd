extends Resource

class_name GData
# EdgeArray is a 2D array of bool
# edge_array[i][j] == true if node i has an edge to node j
# edge_array[i][j] == edge_array[j][i]
var edge_array: Array[Array] = []
# list of nodes, idx corresponding to edge connection in EdgeArray
# node_array[i] corresponds to the same node represented as edge_array[i]
var node_array: Array[GNode] = []
var node_to_idx_dict: Dictionary = {}
var start_node: int

#region Public Methods
func get_number_of_nodes() -> int:
	return node_array.size()
func get_gnode_as_idx(node: GNode) -> int:
	return node_to_idx_dict[node]
func get_idx_as_gnode(node: int) -> GNode:
	return node_array[node]
func get_array_gnodes(nodes: Array[int]) -> Array[GNode]:
	var res: Array[GNode] = []
	for idx in nodes:
		res.push_back(node_array[idx])
	return res
func is_gnodes_connected(node1: GNode, node2: GNode) -> bool:
	return is_nodes_connected(node_to_idx_dict[node1], node_to_idx_dict[node2])
func is_nodes_connected(node1_idx: int, node2_idx: int) -> bool:
	return edge_array[node1_idx][node2_idx]

# return a list of idx that are connected to the given node
func get_adjacent_idx(node_idx: int) -> Array[int]:
	var adjacent: Array[int] = []
	for i in range(edge_array[node_idx].size()):
		if (is_nodes_connected(node_idx, i)):
			adjacent.push_back(i)
	return adjacent

# initialise all arrays and fill with valid data
func create_edge_array(nodes: Array[GNode], edges: Array[Edge]) -> int:
	clear_all_arrays()
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

# Set which node is the given start node for all algorithms
func set_start_gnode(start: GNode) -> void:
	if (node_to_idx_dict.is_empty()):
		print_debug("Empty Node To IDX dict")
	start_node = node_to_idx_dict[start]
#endregion


func initialise_edge_array(n: int) -> void:
	for i in range(n):
		edge_array.push_back([])
		for j in range(n):
			edge_array.back().push_back(false)

func clear_all_arrays() -> void:
	node_array.clear()
	edge_array.clear()
	node_to_idx_dict.clear()

func set_node_array(nodes: Array[GNode]) -> void:
	for i in range(nodes.size()):
		node_array.push_back(nodes[i])
		node_to_idx_dict[nodes[i]] = i


