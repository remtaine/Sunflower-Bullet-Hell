class_name BulletPool
extends Node2D

onready var player_texture = preload("res://images/characters/player/sunflower petal bullet.png")
onready var enemy_texture = preload("res://images/bullets/enemy bullets/Projectile 1.png")

const BULLET_SPEED = 100
const COLLISION_DISTANCE = 0#10
var bullets := []
var bullets_data := []

var bullets_removed := 0

var bullet_textures : Dictionary

func _ready():
	bullet_textures = {
	"player": player_texture,
	"enemy": enemy_texture
}

func _physics_process(delta):
	bullets_removed = 0
	if bullets.size() <= 0:
		return
	for index in range (bullets.size()):
		var i = index - bullets_removed
		var bullet = bullets[i]
		var bullet_data = bullets_data[i]
		
		#move
		bullet_data["direction"] = bullet_data["direction"].rotated(bullet_data["curved_accel"]/PI)
		bullet_data["velocity"] += bullet_data["linear_accel"] * bullet_data["direction"]
		bullet.position += bullet_data["velocity"] * delta
		
		#check collision
		for character in get_parent().get_node("Characters").get_children():
				if bullet.position.distance_to(character.position) < COLLISION_DISTANCE: #ie with collisions
					if bullet_data["character_type"] != character.character_type and character.visible:
						free_bullet(i)
						character.die()

		#check if offscreen
		if bullet.position.x < 125 or bullet.position.x > 825: #ie offscreen
			free_bullet(i)
		elif bullet.position.y < -25 or bullet.position.y > 500: #ie offscreen
#		elif bullet.position.y < GameInfo.level_borders.position.y or bullet.position.y > 540: #ie offscreen
			free_bullet(i)

func free_bullet(i : int):
	var bullet = bullets[i]
	bullets.remove(i)
	bullets_data.remove(i)
	bullets_removed += 1
	bullet.queue_free()
	
func shoot(pos : Vector2, dir :Vector2, ct : String, l_accel := 0.0, c_accel := 0.0, spd := BULLET_SPEED, sz := 0.3):
	var sprite = Sprite.new()
	sprite.scale *= sz
	sprite.texture = bullet_textures[ct]
	sprite.position = to_local(pos)
	print ("Position: ", pos, "vs sprite pos: ", sprite.position)
	bullets_data.push_back({
		"direction": dir,
		"linear_accel": l_accel,
		"curved_accel": c_accel,
		"velocity": spd * dir,
		"size": sz,
		"character_type": ct
	})
	bullets.push_back(sprite)
	sprite.visible = true
	add_child(sprite)
	
