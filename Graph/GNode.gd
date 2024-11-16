class_name GNode

extends Node2D



var mouse_offset: Vector2 = Vector2.ZERO
var dragging := false
var mouse_over := false
var clicked_time: float = INF
var select_for_edit_threshold: float = 0.15

signal edit_edge_button_clicked(this_gnode)
signal edit_node_button_clicked(this_gnode)
signal dragging_node(this_gnode)

#region Dragging	
func check_dragging(event: InputEvent):
	if (event.is_action_pressed("left_mouse")):
		get_viewport().set_input_as_handled()
		mouse_offset = global_position - get_global_mouse_position()
		dragging = true
		clicked_time = 0.0
func handle_dragging(delta: float):
	if (dragging):
		clicked_time += delta
		position = get_global_mouse_position() + mouse_offset
		dragging_node.emit(self)
#endregion
#region Edges
func check_edit(event: InputEvent):
	if (event.is_action_pressed("right_mouse")):
		get_viewport().set_input_as_handled()
		edit_edge()

func edit_edge():
	edit_edge_button_clicked.emit(self)

func add_edge(edge: Edge, other: GNode):
	pass
#endregion
#region Editing Node
func handle_short_click():
	# can this be cleaner?
	if (mouse_over && !dragging):
		if (clicked_time <= select_for_edit_threshold):
			edit_node()
		clicked_time = INF

func edit_node():
	print_debug("edit node")
#endregion

#region Main Functions
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	handle_dragging(delta)
	handle_short_click()

func _unhandled_input(event: InputEvent) -> void:
	if (mouse_over):
		check_dragging(event)	
		check_edit(event)
	
	if (event.is_action_released("left_mouse")):
		dragging = false

#endregion
func mouse_clicked() -> void:
	print_debug("mouse clicked")


# signal receiver for mouse_entered and mouse_exited
func _mouse_over(value):
	mouse_over = value
