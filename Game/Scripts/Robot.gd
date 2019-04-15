extends "res://Scripts/Character.gd"

func _ready():
	$RobotArmature/AnimationPlayer.get_animation("Robot_Running").set_loop(true)
	can_fire = true
	pass

func _physics_process(delta):
	if $RayCast.is_colliding() and can_fire:
		fire()
		can_fire = false
		$CanFire.start()
		pass