extends ColorRect

var slot_id := -1
const DARK_SLOT = "b48664"
@onready var filter: ColorRect = $Filter
signal slot_clicked(slot)
var state = DataHandler.SLOT_STATE.NONE


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_background(isOdd: bool) -> void:
	if(isOdd): color = DARK_SLOT

func set_filter(color = DataHandler.SLOT_STATE.NONE):
	state = color
	match state:
		DataHandler.SLOT_STATE.NONE:
			filter.color = Color(0, 0, 0, 0)
		DataHandler.SLOT_STATE.FREE:
			filter.color = Color(0, 1, 0, 0.3)

func _on_filter_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		emit_signal("slot_clicked", self)
