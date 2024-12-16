extends Node2D


@onready var graph := $Graph
@onready var camera := $Camera2D
@onready var options := $CanvasLayer/OptionsMenu

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
	options.get_current_algorithm().initialise_algorithm(graph.get_graph_data())
	graph.reset_node_colours(graph.get_graph_data().node_array)
func step_algorithm():
	options.get_current_algorithm().step()
	var dsp = options.get_current_algorithm().get_display_data()
	graph.set_graph_display(dsp)
#endregion

