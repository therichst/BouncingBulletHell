extends CharacterBody2D

@export var speed: float = 400.0
@export var damage: int = 1
@export var bounce_lifetime: float = 0.5

var direction: Vector2 = Vector2.RIGHT
var has_bounced: bool = false

func _ready() -> void:
	collision_layer = 0 # Prevents bullets from blocking the Player or hitting each other
	velocity = direction.normalized() * speed
	rotation = velocity.angle()
	velocity = direction.normalized() * speed
	rotation = velocity.angle()

func _physics_process(delta: float) -> void:
	# Move the bullet and check if it hits anything this frame
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		var collider: Object = collision.get_collider()
		if collider.is_in_group("PLAYER") :
			get_tree().create_timer(bounce_lifetime).timeout.connect(queue_free)
		
		# 2. Otherwise, it hit a wall (StaticBody2D) -> Bounce off
		var normal: Vector2 = collision.get_normal()
		velocity = velocity.bounce(normal)
		rotation = velocity.angle()
		
		# Start the 0.5s despawn timer on the first wall bounce
		if not has_bounced:
			has_bounced = true
			get_tree().create_timer(bounce_lifetime).timeout.connect(queue_free)
