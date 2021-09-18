extends RigidBody2D

signal hit

export var min_speed = 150
export var max_speed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Mob_body_entered(body):
	hide()
	emit_signal("hit")
	# Ensure hit signal only triggers once
	$CollisionShape2D.set_deferred("disabled", true)
