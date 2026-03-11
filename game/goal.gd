extends Node2D

@export var score: int = 0

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.area_entered.connect(ball_entered_area_2d)
	
	
func ball_entered_area_2d(body: Node2D):
	if body.is_in_group("Ball"):
		GameState.goal_scored.emit(name, 1)
