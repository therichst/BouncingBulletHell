extends CharacterBody2D

var Health = 5

#SPEEEDEDEDDEDEDEDEDEDE
var SPEED = 700.0

var collide: Node2D

# Var dump
var IsDash
var DashDir
var Dtime = 0.25

@export var health: int = 5

func _physics_process(delta: float) -> void:
	
#	direction
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
#	Mantul
	var collision_info = move_and_collide(velocity*delta)
	
#	Movement
	if Input.is_action_just_pressed("Dash") and not IsDash:
		DashDir = direction
		IsDash = true
	else :
		velocity = SPEED * direction
	
	if collision_info:
		collide = collision_info.get_collider()
		if collide.is_in_group("BULLET"):
			return
		
	
	if IsDash:
		if Dtime > 0:
			Dtime -= delta
			velocity = DashDir * 2500.0
			collision_info
			if collision_info:
				if collide.is_in_group("BOSS") :
					IsDash = false
					velocity = velocity.bounce(collision_info.get_normal())*5.0
					collision_info
				if collide.is_in_group("WALL") :
					IsDash = false
					velocity = velocity.bounce(collision_info.get_normal())*5.0
			
		else :
			Dtime = 0.25
			IsDash = false
			
