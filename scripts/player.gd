extends Area2D

signal hit()


@export var speed = 400 #how fast the player will move (pixels/sec).
@export var explode_scene: PackedScene
@export var trail_scene: PackedScene 
@export var trail_interval := 0.1      # seconds between trail spawns
var time_since_trail := 0.0
var screen_size #size of the game window.
var player_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player_size = $CollisionShape2D.shape.get_rect().size
	hide()
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_trail += delta
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO+player_size/2, screen_size-player_size/2)
	
	if velocity.x != 0 or velocity.y != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		if time_since_trail >= trail_interval:
			spawn_trail()
			time_since_trail = 0.0


func _on_body_entered(body):
	var boom = explode_scene.instantiate()
	boom.position = body.position
	get_parent().add_child(boom)
	boom.play()
	hide() # Player disappears after being hit.
	hit.emit()
	set_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	body.queue_free()
	$Explosion.play()

func start(pos):
	position = pos
	show()
	set_process(true)
	$CollisionShape2D.disabled = false

func spawn_trail():
	var trail = trail_scene.instantiate()
	trail.scale = $AnimatedSprite2D.scale
	get_parent().add_child(trail)
	trail.global_position = $AnimatedSprite2D.global_position
	trail.z_index = z_index - 1
