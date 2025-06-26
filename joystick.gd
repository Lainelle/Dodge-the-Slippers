extends Control

var origin := Vector2.ZERO
var max_radius := 80.0

@onready var bg = $Bg
@onready var knob = $Knob

func _ready():
	hide()
	knob.position = Vector2.ZERO
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			origin = event.position
			global_position = origin
			knob.position = Vector2.ZERO
			show()
		else:
			_release()
	elif event is InputEventScreenDrag and visible:
		var offset = event.position - origin
		_process_stick(offset)

func _release():
	for action in ["move_right", "move_left", "move_up", "move_down"]:
		Input.action_release(action)
	hide()
	knob.position = Vector2.ZERO

func _process_stick(offset: Vector2):
	var norm = offset.clamp(Vector2(-max_radius, -max_radius), Vector2(max_radius, max_radius))
	var dir = norm / max_radius
	knob.position = norm
	Input.action_press("move_right", max(dir.x, 0.0))
	Input.action_press("move_left", max(-dir.x, 0.0))
	Input.action_press("move_down", max(dir.y, 0.0))
	Input.action_press("move_up", max(-dir.y, 0.0))
