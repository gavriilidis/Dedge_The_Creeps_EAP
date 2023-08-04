extends Node

export (PackedScene) var Mob
export (PackedScene) var Mob2
export (PackedScene) var Mob3

var score



func _ready():
	randomize()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Ετοιμάσου")
	$Music.play()


func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob2 = Mob2.instance()
	add_child(mob2)
	# Set the mob's position to a random location.
	mob2.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob2.rotation = direction
	# Set the velocity (speed & direction).
	mob2.linear_velocity = Vector2(rand_range(mob2.min_speed, mob2.max_speed), 0)
	mob2.linear_velocity = mob2.linear_velocity.rotated(direction)

	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob3 = Mob3.instance()
	add_child(mob3)
	# Set the mob's position to a random location.
	mob3.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob3.rotation = direction
	# Set the velocity (speed & direction).
	mob3.linear_velocity = Vector2(rand_range(mob3.min_speed, mob3.max_speed), 0)
	mob3.linear_velocity = mob3.linear_velocity.rotated(direction)
	
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
