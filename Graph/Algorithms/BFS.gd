extends Resource

class_name BFS
# All algorithms represent nodes as simply ints, corresponding to the nodes stored in
# a GData object. GData objects can be passed between different algorithms, which can produce
# different results

@export var algorithm_name = "BFS"
var graph_data: GData = null

# reimpliment as queues
var explored: Array[int] = []
var boundary: Array[int] = []
var stored_current_node: int = -1
var algorithm_finished: bool = false
#region Public Methods
func reset():
	explored.clear()
	boundary.clear()
	
	boundary.push_back(graph_data.start_node)
	algorithm_finished = false
	stored_current_node = -1

func initialise_algorithm(data: GData):
	graph_data = data
	reset()
	
func get_display_data():
	# return the current node, boundary nodes and explored nodes for visualisation
	# all should be lists
	return [
		graph_data.get_idx_as_gnode(stored_current_node), 
		graph_data.get_array_gnodes(boundary), 
		graph_data.get_array_gnodes(explored)]

# steps through the algorithm
# TEMP just return the explored nodes
func step() -> Array[int]:
	var current_node = get_next_node()
	stored_current_node = current_node
	if (algorithm_finished):
		print_debug("algo finished")
		return explored
	
	if (current_node in explored):
		return step()
	
	var adjacent = graph_data.get_adjacent_idx(current_node)
	boundary.append_array(adjacent)
	explored.push_back(current_node)
	
	return explored
#endregion

func get_next_node() -> int:
	if (boundary.is_empty()):
		algorithm_finished = true
		return -1
	return boundary.pop_front()
