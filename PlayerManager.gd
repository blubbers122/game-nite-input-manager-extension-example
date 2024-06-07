extends Node2D

@export var input_manager: GameNiteInputManager
@export var player_scene: PackedScene

func _ready():
	input_manager.client_added.connect(spawn_player)
	input_manager.client_disconnected.connect(despawn_player)


func despawn_player(client: String):
	var player_node = get_tree().get_nodes_in_group('player').filter(func(p: Player): return p.id == client)
	if not player_node.is_empty():
		player_node[0].queue_free()

func spawn_player(client: String):
	var player: Player = player_scene.instantiate()
	player.id = client
	get_parent().add_child(player)
