class_name OptionsMenu
extends Control

signal algorithm_changed
@export var algorithms: Array[Algorithm]
@onready var algorithm_option_button := $VBoxContainer/AlgorithmOption

@onready var picker := $ColorPicker

func _ready() -> void:
	algorithm_option_button.clear()
	for algo in algorithms:
		algorithm_option_button.add_item(algo.algorithm_name)
		
	# add the colour rect signals
	getNeutralColorRect().colour_rect_clicked.connect(on_colour_rect_clicked)
	getCurrentColorRect().colour_rect_clicked.connect(on_colour_rect_clicked)
	getBoundaryColorRect().colour_rect_clicked.connect(on_colour_rect_clicked)
	getExploredColorRect().colour_rect_clicked.connect(on_colour_rect_clicked)

func on_colour_rect_clicked(rect: ColorRect):
	picker.make_visible(rect)

func _on_algorithm_option_item_selected(index: int) -> void:
	#algorithm_changed.emit(algorithms[index])
	pass

func getNeutralColorRect():
	return $VBoxContainer/GridContainer/crRectNeutral
func getCurrentColorRect():
	return $VBoxContainer/GridContainer/crRectCurrent
func getBoundaryColorRect():
	return $VBoxContainer/GridContainer/crRectBoundary
func getExploredColorRect():
	return $VBoxContainer/GridContainer/crRectExplored


