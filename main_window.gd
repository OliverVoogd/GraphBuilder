extends Node2D


@onready var graph := $Graph
@onready var camera := $Camera2D

#region Algoritms
@export var current_algorithm: BFS
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


#region UI Buttons
func _on_btn_temp_pressed() -> void:
	graph.load_graph_data()
	setup_algorithm()
func _on_btn_step_algorithm_pressed() -> void:
	step_algorithm()
#endregion

#region Algorithm Functions
func setup_algorithm():
	current_algorithm.initialise_algorithm(graph.get_graph_data())
func step_algorithm():
	print_debug(current_algorithm.step())
#endregion

