extends Node2D


@onready var graph := $Graph
@onready var camera := $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


#region UI Buttons
func _on_btn_temp_pressed() -> void:
	graph.collect_nodes()
#endregion



