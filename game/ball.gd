extends RigidBody2D

@onready var authority_label : Label = $Label

func _process(_delta: float) -> void:
	authority_label.text = str(get_multiplayer_authority())