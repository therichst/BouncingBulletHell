extends CharacterBody2D

#Global
static var Hit = 15

#SPEEEDEDEDDEDEDEDEDEDE
var SPEED = 500.0

# Var dump
var i

func _physics_process(delta: float) -> void:
	
#	direction
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
#	Mantul
	var collision_info = move_and_collide(velocity*delta)
	
#	Movement
	if Input.is_action_just_pressed("Dash"):
		velocity = 10000 * direction
		if collision_info:
			move_and_collide(velocity.bounce(collision_info.get_normal())/20)
			if collision_info.get_collider().name == "Boss":
				Hit = Hit-1
	else :
		velocity = SPEED * direction
	
