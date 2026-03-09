extends RigidBody2D

class_name Ball

@onready var authority_label : Label = $Label

func _enter_tree():
	# With mesh type, be client authority.
	set_multiplayer_authority(str(name).to_int())
	#player_input.set_multiplayer_authority(str(name).to_int()
	
func _ready() -> void:
	if not is_multiplayer_authority():
#		set_process(false)
		set_physics_process(false)
		
func _process(_delta: float) -> void:
	authority_label.text = self.name