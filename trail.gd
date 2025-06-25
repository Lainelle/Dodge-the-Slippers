extends Node2D

@export var shrink_rate := 3.0    # How fast to shrink (scale units per second)

func _process(delta):
	scale -= Vector2.ONE * shrink_rate * delta
	if scale.x <= 0 or scale.y <= 0:
		queue_free()
