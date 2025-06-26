extends Control

var is_dragging = false
var center_pos = Vector2.ZERO

@onready var stick_base = $StickBase  # Фон стика
@onready var stick_handle = $StickHandle  # Сам движущийся кружок

func _ready():
	hide_stick()

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			start_drag(event.position)
		else:
			end_drag()

	elif event is InputEventScreenDrag and is_dragging:
		process_stick(event.position)

func start_drag(pos):
	is_dragging = true
	center_pos = pos
	show_stick(pos)
	process_stick(pos)

func end_drag():
	is_dragging = false
	hide_stick()
	release_all_actions()

func process_stick(pos):
	var dir = (pos - center_pos)
	var length = dir.length()
	var max_length = 100.0  # Радиус стика

	if length > max_length:
		dir = dir.normalized() * max_length

	stick_handle.position = dir

	var normalized_dir = (pos - center_pos).normalized()

	Input.action_release("move_left")
	Input.action_release("move_right")
	Input.action_release("move_up")
	Input.action_release("move_down")

	if normalized_dir.x > 0.5:
		Input.action_press("move_right")
	elif normalized_dir.x < -0.5:
		Input.action_press("move_left")

	if normalized_dir.y < -0.5:
		Input.action_press("move_up")
	elif normalized_dir.y > 0.5:
		Input.action_press("move_down")

func release_all_actions():
	for action in ["move_left", "move_right", "move_up", "move_down"]:
		Input.action_release(action)

func show_stick(pos):
	position = pos - stick_base.size / 2
	stick_base.visible = true
	stick_handle.visible = true
	stick_handle.position = Vector2.ZERO

func hide_stick():
	stick_base.visible = false
	stick_handle.visible = false
	
