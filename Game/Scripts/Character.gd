extends KinematicBody

const PROJECTILE_SPEED = 50

enum CHARACTER_TYPES {player, npcs}
var character_type

var can_fire = true
var lives = 3

var ammo_types = {}

func _enter_tree(): #chamado quando entra no nó. vem antes de ready
	ammo_types = File_Grabber.get_files("res://Scenes/Ammo/AmmoModels/")
	randomize()

func fire():
		var random_bullet = ammo_types[randi() % ammo_types.size()]
		var bullet = load(random_bullet).instance()
		add_child(bullet)
		bullet.fired_by = character_type
		bullet.set_as_toplevel(true) #Ignora as transformações dos parentes
		bullet.global_transform = $Forward.global_transform
		var character_forward = get_global_transform().basis[2].normalized()
		bullet.set_linear_velocity(character_forward * PROJECTILE_SPEED)
		#bullet.add_collision_exception_with(self) #Evite colidir consigo mesmo.
	

func _on_CanFire_timeout():
	can_fire = true

func hurt(hurt_by):
	if character_type != hurt_by:
		$HurtSFX.play()
		lives -=1
		pass

func check_lives():
	if lives < 1:
		die()

func die():
	queue_free()
