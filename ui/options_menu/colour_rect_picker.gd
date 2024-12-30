extends ColorPicker

var currentRect: ColorRect

signal colour_picker_changed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_changed.connect(on_colour_changed)
	

func on_colour_changed(color: Color):
	if currentRect:
		currentRect.color = color
		colour_picker_changed.emit()

func _process(delta: float) -> void:
	if visible and not Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		visible = false


func make_visible(rect: ColorRect):
	visible = true
	set_global_position(get_global_mouse_position() - Vector2(size.x, 0.0) + Vector2(5.0, -5.0))
	color = rect.color
	currentRect = rect
	
