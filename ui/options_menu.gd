class_name OptionsMenu
extends Control

signal algorithm_changed
@export var algorithms: Array[Algorithm]
@onready var algorithm_option_button := $VBoxContainer/AlgorithmOption

func _ready() -> void:
	algorithm_option_button.clear()
	for algo in algorithms:
		algorithm_option_button.add_item(algo.algorithm_name)

func getNeutralColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectNeutral
func getCurrentColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectCurrent
func getBoundaryColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectBoundary
func getExploredColorRect() -> ColorRect:
	return $VBoxContainer/GridContainer/crRectExplored


func _on_algorithm_option_item_selected(index: int) -> void:
	#algorithm_changed.emit(algorithms[index])
	pass
