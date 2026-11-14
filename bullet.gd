extends CharacterBody2D


var BSpeed
var rng = RandomNumberGenerator.new()
var dir :Vector2 = Vector2(0,0)
var halt

func _ready():
	while true:
		halt = randf_range(1,3)
		dir.x = randi_range(-1,1)
		dir.y = randi_range(-1,1)
		BSpeed = randf_range(50,90)
		await get_tree().create_timer(halt).timeout
	

func _physics_process(delta: float) -> void:
	velocity = BSpeed * dir
	move_and_slide()
