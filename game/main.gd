extends Node

@export var use_quick_connect: bool = true

var game_world: PackedScene = preload("res://game/world.tscn")

func _ready() -> void:
	get_node_or_null("LobbyQuickConnect").show()


	# Game start signal
	LobbySystem.signal_client_connection_started.connect(new_game_connection)

func new_game_connection():
	if get_node_or_null("World") == null:
		if get_node_or_null("LobbyMenu"): get_node("LobbyMenu").hide()
		if get_node_or_null("LobbyQuickConnect"): get_node("LobbyQuickConnect").hide()
		var new_world: Node = game_world.instantiate()
		add_child(new_world)
