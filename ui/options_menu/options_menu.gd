class_name OptionsMenu
extends Control

signal algorithm_changed
signal colours_changed
@export var algorithms: Array[Algorithm]
@onready var algorithm_option_button := $VBoxContainer/AlgorithmOption

@onready var picker := $ColourPicker
var colour_rects: Array[ColorRect]

func _ready() -> void:
	algorithm_option_button.clear()
	for algo in algorithms:
		algorithm_option_button.add_item(algo.algorithm_name)
	
	# add the colour rect signals
	colour_rects = [
		getNeutralColorRect(), getCurrentColorRect(), getBoundaryColorRect(), getExploredColorRect()
	]
	for rect in colour_rects:
		rect.gui_input.connect(on_color_rect_clicked.bind(rect))
		
	# connect to the colour picker changing signal
	picker.colour_picker_changed.connect(on_colours_changed)
	colours_changed.emit()

func get_current_algorithm() -> Algorithm:
	return algorithms[algorithm_option_button.selected]

#region Color Rects
func on_color_rect_clicked(event: InputEvent, rect: ColorRect):
	if (event.is_action_pressed("left_mouse")):
		picker.make_visible(rect)
func on_colours_changed() -> void:
	colours_changed.emit()
	print_debug("colours changed")

func getNeutralColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectNeutral
func getCurrentColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectCurrent
func getBoundaryColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectBoundary
func getExploredColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectExplored
#endregion

