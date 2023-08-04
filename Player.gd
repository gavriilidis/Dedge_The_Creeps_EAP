extends Area2D

signal hit

export var speed = 400
onready var ShieldTimer = $ShieldTimer
onready var BlockShieldTimer = $BlockShieldTimer
onready var ShieldSprite = $Shield
var screen_size

func _ready():
	BlockShieldTimer = false
	ShieldSprite.visible = false
	screen_size = get_viewport_rect().size
	hide()
	
	
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
	if Input.is_key_pressed(KEY_SPACE):
		if BlockShieldTimer:
			return
		ShieldTimer.start()
		ShieldSprite.visible = true

func _on_ShieldTimer_timeout():
	ShieldSprite.hide()
	BlockShieldTimer = true

func _on_BlockShieldTimer_timeout():
	BlockShieldTimer = false
	
func _on_Player_body_entered(body):
	if ShieldSprite.visible:
		return
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false



