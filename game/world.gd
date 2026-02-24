extends Node2D

class_name World

signal signal_player_death(id)
signal signal_player_kill(id)

@onready var player_container: Node2D = $PlayerContainer
@onready var ball_container: Node2D = $BallContainer
@onready var ball_spawner: MultiplayerSpawner = $BallSpawner

var player_scene: PackedScene = preload("res://game/player.tscn")
var ball_scene: PackedScene = preload("res://game/ball.tscn")

func _ready() -> void:
	add_to_group('World')
	LobbySystem.add_player_to_game(multiplayer.get_unique_id())
	if LobbySystem.host != null:
		add_ball_to_world(int(LobbySystem.ws_peer_id))

@rpc("any_peer", 'call_local', 'reliable')
func broadcast_player_death(id: String):
	signal_player_death.emit(id)
	
@rpc("any_peer", 'call_local', 'reliable')
func broadcast_player_kill(id: String):
	signal_player_kill.emit(id)


func add_player_to_world(peer_id: int):
	var new_player: Player = player_scene.instantiate()
	new_player.name = str(peer_id)
	new_player.position = Vector2(randi_range(-2, 2), randi_range(-2, 2)) * 10
	player_container.add_child(new_player, true)

func add_ball_to_world(peer_id: int) -> void:
	if ball_container.get_child_count() >= 1: return
	
	var new_ball := ball_scene.instantiate()
	new_ball.set_multiplayer_authority(peer_id)
	new_ball.position = Vector2(randi_range(-2, 2), randi_range(-2, 2)) * 10
	
	ball_container.add_child(new_ball, true)
