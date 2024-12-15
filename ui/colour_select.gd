extends ColorRect

var mouse_within := false

func _ready() -> void:
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_gui_input(event: InputEvent) -> void:
	if (event.is_action_pressed("left_mouse") and mouse_within):
		# bring up the colour picker!
		print_debug("mouse clicked colour picker")

func on_mouse_entered() -> void:
	mouse_within = true
func on_mouse_exited() -> void:
	mouse_within = false
