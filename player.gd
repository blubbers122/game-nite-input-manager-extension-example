class_name Player extends CharacterBody2D

@export var id: String = ''
var speed = 200



func _process(delta):
	if is_queued_for_deletion():
		return
	var move_vector = Input.get_vector(id + '_stick_left', id + '_stick_right', id + '_stick_up', id + '_stick_down')
	
	if Input.is_action_just_pressed(id +'_A'):
		scale *= 1.1
	elif Input.is_action_just_pressed(id + '_B'):
		scale = Vector2.ONE

	velocity = velocity.move_toward(move_vector * speed, delta * 1000)
	move_and_slide()
