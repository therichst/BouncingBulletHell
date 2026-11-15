extends CharacterBody2D

const BULLET_SCENE: PackedScene = preload("res://bullet.tscn")

static var Hit
var BSpeed
var rng = RandomNumberGenerator.new()
var dir :Vector2 = Vector2(0,0)
var halt = 0


func _ready():
	while true :
		await get_tree().create_timer(0.1).timeout
		shoot_at_angle(rng.randf_range(-360,360))
	

func _physics_process(delta: float) -> void:
	if halt > 0 :
		halt -= delta
		velocity = BSpeed * dir.normalized()
		move_and_slide()
	else :
		dir.x = randi_range(-PI,PI)
		dir.y = randi_range(-PI,PI)
		BSpeed = randf_range(50,90)
		halt = randf_range(1,3)

	
func shoot_at_angle(angle_radians: float) -> void:
	var bullet = BULLET_SCENE.instantiate()
	bullet.global_position = global_position
	bullet.direction = Vector2.from_angle(angle_radians)
	bullet.add_collision_exception_with(self) # Ignore Boss collision on spawn
	get_tree().current_scene.add_child(bullet)
