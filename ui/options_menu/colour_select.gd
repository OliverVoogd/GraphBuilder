extends ColorRect

var mouse_within := false

signal colour_rect_clicked(colour_rect)

func _ready() -> void:
	gui_input.connect(on_gui_input)
	
func on_gui_input(event: InputEvent) -> void:
	if (event.is_action_pressed("left_mouse")):
		# bring up the colour picker!
		colour_rect_clicked.emit(self)
#
