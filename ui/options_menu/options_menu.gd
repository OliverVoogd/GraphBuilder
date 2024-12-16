class_name OptionsMenu
extends Control

signal algorithm_changed
@export var algorithms: Array[Algorithm]
@onready var algorithm_option_button := $VBoxContainer/AlgorithmOption

@onready var picker := $ColorPicker
var color_rects: Array[ColorRect]

func _ready() -> void:
	algorithm_option_button.clear()
	for algo in algorithms:
		algorithm_option_button.add_item(algo.algorithm_name)
	
	# add the colour rect signals
	color_rects = [
		getNeutralColorRect(), getCurrentColorRect(), getBoundaryColorRect(), getExploredColorRect()
	]
	for rect in color_rects:
		rect.gui_input.connect(on_color_rect_clicked.bind(rect))

func _on_algorithm_option_item_selected(index: int) -> void:
	#algorithm_changed.emit(algorithms[index])
	pass

#region Color Rects
func on_color_rect_clicked(event: InputEvent, rect: ColorRect):
	if (event.is_action_pressed("left_mouse")):
		picker.make_visible(rect)

func getNeutralColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectNeutral
func getCurrentColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectCurrent
func getBoundaryColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectBoundary
func getExploredColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectExplored
#endregion

