class_name CoinHandler
extends Node2D

onready var coin_resource = preload("res://src/objects/Coin.tscn")
var player
export (int) var coin_score = 100
signal coin_picked_up
onready var level =get_parent().get_parent()

var DISTANCES = {
	PICKUP = 50,
	MOVE = 150,
}

func _ready() -> void:
	player = GameInfo.current_player
	var _succesful_connection = connect("coin_picked_up", level,"update_score")

func _physics_process(delta: float) -> void:
	for coin in get_children():
		if coin is AudioStreamPlayer:
			continue
		coin.rotation_degrees += 3
		if player.visible:
			var dist = coin.global_position.distance_to(player.global_position)
			if dist < DISTANCES.PICKUP:
#				if !$CoinPickup.playing:
#					$CoinPickup.play()
				$CoinSpawn.play()
#				$CoinPickup.play()
				emit_signal("coin_picked_up",coin_score * coin.scale.x)
				#TODO add pickup sound
				coin.queue_free()
			elif dist < DISTANCES.MOVE:
				var v = coin.global_position.direction_to(player.global_position)
				coin.global_position += v * delta * 1.2 * (DISTANCES.MOVE - dist)
			
			coin.global_position += Vector2.DOWN * delta * 80
		
		if coin.global_position.y > GameInfo.GAME_BORDER_END.y + 100:
			coin.queue_free()
				
func spawn_coins(num : int, pos: Vector2, sc := 1, explosion_strength := 1, rand := 0.6):
	for i in range (num):
		$CoinSpawn.play()
		randomize()
		var coin = coin_resource.instance()

		coin.scale *= sc * (randf()/3 + 1)
		coin.global_position = pos + (Vector2.LEFT.rotated((randi() % 360)/57) * ((1-(rand)) + (randf() * rand)) * 30 * coin.scale * num/9)
		
		coin.rotation_degrees = randi() % 360

		self.add_child(coin)
