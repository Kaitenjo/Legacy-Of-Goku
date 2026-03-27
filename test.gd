extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_scene: PackedScene = preload(Paths.PLAYER)
	var player: Player = player_scene.instantiate()
	add_child(player)
	player.load_character('Goku', CharacterDTO.new(true, 'classic', 5, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100))
	player.init()
