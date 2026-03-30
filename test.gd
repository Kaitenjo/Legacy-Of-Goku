extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_scene: PackedScene = preload(Paths.PLAYER)
	var player: Player = player_scene.instantiate()
	player.init('goku', CharacterDTO.new(true, 'classic', 5, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100))
	add_child(player)
