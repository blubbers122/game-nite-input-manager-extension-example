class_name GameNiteInputManager extends Node

@export var max_connections: int = 4

var clients: Dictionary = {}

var accepting_clients = true

signal client_added(client: String)
signal client_disconnected(client: String)
signal max_connections_reached
signal connection_spot_opened

func _on_message_received(client: String, message: String):
	
	var message_part_one = message.split(':')[0]
	
	if message != 'quit' and accepting_clients and not clients.has(client):
		clients[client] = true
		add_player_input_map(client)
		client_added.emit(client)
		accepting_clients = clients.size() < max_connections
		if not accepting_clients:
			max_connections_reached.emit()
	
	match message_part_one:
		'stick':
			var move_vector = message.split(':')[1]
			var x = float(move_vector.split(',')[0])
			var y = float(move_vector.split(',')[1])
			move_vector = Vector2(x, y)
			Input.action_press(client + '_stick_right', x / 256)
			Input.action_press(client + '_stick_down', y / 256)
			Input.action_press(client + '_stick_left', -x / 256)
			Input.action_press(client + '_stick_up', -y / 256)
		'pressed':
			var button = message.split(':')[1]
			Input.action_press(client + '_' + button)
		'released':
			var button = message.split(':')[1]
			Input.action_release(client + '_' + button)
		'quit':
			clients.erase(client)
			client_disconnected.emit(client)
			remove_player_input_map(client)
			if not accepting_clients and clients.size() < max_connections:
				connection_spot_opened.emit()
			accepting_clients = clients.size() < max_connections


func add_player_input_map(client: String):
	InputMap.add_action(client + '_stick_right')
	InputMap.add_action(client + '_stick_down')
	InputMap.add_action(client + '_stick_left')
	InputMap.add_action(client + '_stick_up')
	InputMap.add_action(client + '_A')
	InputMap.add_action(client + '_B')
	InputMap.add_action(client + '_X')
	InputMap.add_action(client + '_Y')

func remove_player_input_map(client: String):
	InputMap.erase_action(client + '_stick_right')
	InputMap.erase_action(client + '_stick_down')
	InputMap.erase_action(client + '_stick_left')
	InputMap.erase_action(client + '_stick_up')
	InputMap.erase_action(client + '_A')
	InputMap.erase_action(client + '_B')
	InputMap.erase_action(client + '_X')
	InputMap.erase_action(client + '_Y')



