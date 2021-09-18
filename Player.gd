extends Area2D

signal hit

export (PackedScene) var Bullet

export var speed = 400
var screen_size

# Controls
export var touchInput = true
var click
var clickedPos = position
var velocity = Vector2()


func start(pos):
	position = pos
	clickedPos = position
	show()
	# Re-enable collisions
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide until player has pressed Start
	hide()

func get_input():
	click = Input.is_action_just_pressed("ui_click")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	
	# Ensure player is clicking outside of self
	var distanceFromPlayer = position - clickedPos
	# if distanceFromPlayer.length() > 16:
	if click:
		clickedPos = get_viewport().get_mouse_position()
		# Point player sprite in mouse direction
		# rotation = atan2(position.direction_to(clickedPos).y, position.direction_to(clickedPos).x)
		var direction = (clickedPos - self.position).angle() + PI/2
		rotation = direction
		print("click")
		# Trigger shooting animation
		# Fire projectile
		# Create a mob instance
		var bullet = Bullet.instance()
		add_child(bullet)
		bullet.position = self.position
		bullet.rotation = direction
		#bullet.linear_velocity = Vector2(rand_range(5, 15), 0) # rand number between 5 and 15
		#bullet.linear_velocity = bullet.linear_velocity.rotated(direction)
		# Play shooting sound


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	# Ensure hit signal only triggers once
	$CollisionShape2D.set_deferred("disabled", true)
