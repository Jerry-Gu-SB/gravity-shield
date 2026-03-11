extends CanvasLayer

@onready var goal1_label: Label = $Goal1_Label
@onready var goal2_label: Label = $Goal2_Label

func _ready() -> void:
	GameState.connect("goal_scored", handle_goal_scored)
	
func handle_goal_scored(goal_name: String, point_value: int):
	print("GOOOOOAL: ", goal_name)
	if "1" in goal_name:
		goal1_label.text = str(int(goal1_label.text) + point_value)
	if "2" in goal_name:
		goal2_label.text = str(int(goal2_label.text) + point_value)
	